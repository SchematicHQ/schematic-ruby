# frozen_string_literal: true

require "json"

module Schematic
  class CheckFlagResponse
    attr_reader :value, :flag_key, :flag_id, :reason, :rule_id, :rule_type,
                :company_id, :user_id, :entitlement, :error,
                :feature_allocation, :feature_usage, :feature_usage_event,
                :feature_usage_period, :feature_usage_reset_at

    def initialize(attrs = {})
      @value = attrs[:value] || false
      @flag_key = attrs[:flag_key] || attrs[:flag]
      @flag_id = attrs[:flag_id]
      @reason = attrs[:reason] || ""
      @rule_id = attrs[:rule_id]
      @rule_type = attrs[:rule_type]
      @company_id = attrs[:company_id]
      @user_id = attrs[:user_id]
      @entitlement = attrs[:entitlement]
      @error = attrs[:error] || attrs[:err]
      @feature_allocation = attrs[:feature_allocation]
      @feature_usage = attrs[:feature_usage]
      @feature_usage_event = attrs[:feature_usage_event]
      @feature_usage_period = attrs[:feature_usage_period]
      @feature_usage_reset_at = attrs[:feature_usage_reset_at]
    end

    def to_h
      {
        value: @value,
        flag_key: @flag_key,
        flag_id: @flag_id,
        reason: @reason,
        rule_id: @rule_id,
        rule_type: @rule_type,
        company_id: @company_id,
        user_id: @user_id,
        entitlement: @entitlement,
        error: @error,
        feature_allocation: @feature_allocation,
        feature_usage: @feature_usage,
        feature_usage_event: @feature_usage_event,
        feature_usage_period: @feature_usage_period,
        feature_usage_reset_at: @feature_usage_reset_at
      }.compact
    end
  end

  class SchematicClient
    attr_reader :api_client

    DEFAULT_BASE_URL = "https://api.schematichq.com"
    DEFAULT_CACHE_TTL = 5.0 # seconds
    DEFAULT_CACHE_MAX_SIZE = 1000
    DEFAULT_EVENT_BUFFER_PERIOD = 5.0 # seconds (canonical Go value)

    def initialize(
      api_key: nil,
      base_url: nil,
      offline: false,
      flag_defaults: {},
      cache_providers: nil,
      event_buffer_period: DEFAULT_EVENT_BUFFER_PERIOD,
      event_capture_base_url: nil,
      use_data_stream: false,
      datastream_options: {},
      logger: nil,
      log_level: :info
    )
      @api_key = api_key
      @base_url = base_url || DEFAULT_BASE_URL
      @flag_defaults = flag_defaults.dup
      @flag_defaults_mutex = Mutex.new
      @logger = logger || ConsoleLogger.new(level: log_level)
      @closed = false

      # Auto-enable offline mode if no API key
      if (api_key.nil? || api_key.empty?) && !offline
        @logger.warn("No API key provided, enabling offline mode")
        offline = true
      end
      @offline = offline

      # Initialize Fern-generated API client
      @api_client = if @offline
                      nil
                    else
                      Schematic::Client.new(
                        api_key: @api_key,
                        base_url: @base_url
                      )
                    end

      # Cache setup
      @flag_check_cache_providers = cache_providers || [
        LocalCache.new(max_size: DEFAULT_CACHE_MAX_SIZE, ttl: DEFAULT_CACHE_TTL)
      ]

      # Event buffer setup — sends to capture service (not the Fern API)
      @event_buffer = EventBuffer.new(
        api_key: @api_key || "",
        logger: @logger,
        interval: event_buffer_period,
        offline: @offline,
        capture_base_url: event_capture_base_url || EventBuffer::DEFAULT_CAPTURE_BASE_URL
      )

      # DataStream setup
      @datastream_client = nil
      @rules_engine = nil
      setup_datastream(datastream_options) if use_data_stream && !@offline

      # Register shutdown hook to ensure graceful cleanup on process exit
      at_exit { close }
    end

    # --- Flag Checking ---

    def check_flag(flag_key, company: nil, user: nil)
      check_flag_with_entitlement(flag_key, company: company, user: user).value
    end

    def check_flag_with_entitlement(flag_key, company: nil, user: nil)
      # Offline mode
      if @offline
        return CheckFlagResponse.new(
          value: get_flag_default(flag_key),
          flag_key: flag_key,
          reason: "offline mode"
        )
      end

      # DataStream path
      if @datastream_client&.connected?
        begin
          eval_ctx = build_eval_context(company, user)
          result = @datastream_client.check_flag(eval_ctx, flag_key)

          response = CheckFlagResponse.new(result)
          enqueue_flag_check_event(flag_key, response, company, user)
          return response
        rescue DataStream::EvaluationError => e
          @logger.debug("DataStream flag check unavailable, falling back to API: #{e.message}")
        rescue StandardError => e
          @logger.warn("DataStream flag check failed, falling back to API: #{e.message}")
        end
      end

      # API path with caching
      check_flag_via_api(flag_key, company, user)
    rescue StandardError => e
      @logger.error("check_flag_with_entitlement error for '#{flag_key}': #{e.message}")
      CheckFlagResponse.new(
        value: get_flag_default(flag_key),
        flag_key: flag_key,
        reason: "error: #{e.message}"
      )
    end

    def check_flags(company: nil, user: nil, keys: nil)
      if @offline
        @logger.debug("Offline mode enabled, returning default flag values")
        flag_keys = if keys.nil? || keys.empty?
                      @flag_defaults_mutex.synchronize { @flag_defaults.keys }
                    else
                      keys
                    end
        return flag_keys.map { |k| { flag: k, value: get_flag_default(k), reason: "Offline mode - using default value" } }
      end

      begin
        # DataStream path — try evaluating all requested keys locally
        if @datastream_client&.connected? && keys&.any?
          ds_results = check_flags_via_datastream(keys, company, user)
          return ds_results if ds_results
        end

        eval_body = {}
        eval_body[:company] = company if company&.any?
        eval_body[:user] = user if user&.any?

        # If no keys, call API directly
        if keys.nil? || keys.empty?
          @logger.debug("No specific flag keys provided, calling checkFlags API")
          api_response = @api_client.features.check_flags(**eval_body)
          return api_response.data.flags.map { |f| { flag: f.flag, value: f.value, reason: f.reason } }
        end

        # Check cache for all requested keys
        all_cached = true
        cached_results = {}

        keys.each do |key|
          cache_key = build_cache_key(key, company, user)
          found = false
          @flag_check_cache_providers.each do |provider|
            cached = provider.get(cache_key)
            next unless cached

            cached_results[key] = { flag: key, value: cached.value, reason: cached.reason }
            found = true
            break
          end
          all_cached = false unless found
        end

        # All cached — return without API call
        if all_cached
          @logger.debug("All #{keys.length} flags found in cache")
          return keys.map { |k| cached_results[k] }
        end

        # Any cache miss — fetch fresh values for ALL keys from API to ensure consistency
        @logger.debug("Cache miss for some flags, calling API for all #{keys.length} keys")
        api_response = @api_client.features.check_flags(**eval_body)
        api_results = {}
        api_response.data.flags.each do |f|
          api_results[f.flag] = f

          # Cache the fresh result
          cache_key = build_cache_key(f.flag, company, user)
          response = CheckFlagResponse.new(
            value: f.value,
            flag_key: f.flag,
            flag_id: f.respond_to?(:flag_id) ? f.flag_id : nil,
            reason: f.reason,
            rule_id: f.respond_to?(:rule_id) ? f.rule_id : nil,
            rule_type: f.respond_to?(:rule_type) ? f.rule_type : nil,
            company_id: f.respond_to?(:company_id) ? f.company_id : nil,
            user_id: f.respond_to?(:user_id) ? f.user_id : nil
          )
          @flag_check_cache_providers.each { |p| p.set(cache_key, response) }
        end

        # Build results in requested key order, preferring fresh API values
        keys.map do |key|
          if api_results[key]
            f = api_results[key]
            { flag: f.flag, value: f.value, reason: f.reason }
          else
            { flag: key, value: get_flag_default(key), reason: "Flag not found - using default value" }
          end
        end
      rescue StandardError => e
        @logger.error("Error checking flags: #{e.message}")
        (keys || []).map { |k| { flag: k, value: get_flag_default(k), reason: "Error occurred - using default value: #{e.message}" } }
      end
    end

    # --- Event Submission ---

    def identify(body)
      return if @offline

      @event_buffer.push({
                           event_type: "identify",
                           body: body,
                           sent_at: Time.now.utc.iso8601
                         })
    rescue StandardError => e
      @logger.error("Error sending identify event: #{e.message}")
    end

    def track(body)
      return if @offline

      @event_buffer.push({
                           event_type: "track",
                           body: body,
                           sent_at: Time.now.utc.iso8601
                         })

      # Update company metrics locally if DataStream is active and connected
      if @datastream_client&.connected? && body[:company]
        event_name = body[:event] || body["event"]
        quantity = body[:quantity] || body["quantity"] || 1
        @datastream_client.update_company_metrics(body[:company], event_name, quantity)
      end
    rescue StandardError => e
      @logger.error("Error sending track event: #{e.message}")
    end

    # --- Flag Defaults ---

    def set_flag_default(flag_key, value)
      @flag_defaults_mutex.synchronize do
        @flag_defaults[flag_key] = value
      end
    end

    def set_flag_defaults(defaults) # rubocop:disable Naming/AccessorMethodName
      @flag_defaults_mutex.synchronize do
        @flag_defaults.merge!(defaults)
      end
    end

    # --- Fern API Access ---

    def accounts
      @api_client&.accounts
    end

    def billing
      @api_client&.billing
    end

    def companies
      @api_client&.companies
    end

    def credits
      @api_client&.credits
    end

    def checkout
      @api_client&.checkout
    end

    def entitlements
      @api_client&.entitlements
    end

    def plans
      @api_client&.plans
    end

    def components
      @api_client&.components
    end

    def dataexports
      @api_client&.dataexports
    end

    def events
      @api_client&.events
    end

    def features
      @api_client&.features
    end

    def planbundle
      @api_client&.planbundle
    end

    def plangroups
      @api_client&.plangroups
    end

    def planmigrations
      @api_client&.planmigrations
    end

    def componentspublic
      @api_client&.componentspublic
    end

    def scheduledcheckout
      @api_client&.scheduledcheckout
    end

    def accesstokens
      @api_client&.accesstokens
    end

    def webhooks
      @api_client&.webhooks
    end

    # --- Lifecycle ---

    def close
      return if @closed

      @closed = true
      @event_buffer.stop
      @datastream_client&.close
      @flag_check_cache_providers.each { |c| c.stop if c.respond_to?(:stop) }
      @logger.debug("SchematicClient closed")
    end

    private

    # --- Internal Flag Checking ---

    def check_flag_via_api(flag_key, company, user)
      # Check cache
      cache_key = build_cache_key(flag_key, company, user)
      @flag_check_cache_providers.each do |provider|
        cached = provider.get(cache_key)
        if cached
          @logger.debug("Flag '#{flag_key}' found in cache (value=#{cached.value})")
          return cached
        end
      end

      # Call API
      begin
        @logger.debug("Flag '#{flag_key}' not in cache, calling API")
        eval_body = {}
        eval_body[:company] = company if company&.any?
        eval_body[:user] = user if user&.any?

        api_response = @api_client.features.check_flag(key: flag_key, **eval_body)
        data = api_response.data
        @logger.debug("API returned flag '#{flag_key}' value=#{data.value}, reason=#{data.reason}")

        response = CheckFlagResponse.new(
          value: data.value,
          flag_key: data.flag,
          flag_id: data.flag_id,
          reason: data.reason,
          rule_id: data.rule_id,
          rule_type: data.rule_type,
          company_id: data.company_id,
          user_id: data.user_id,
          error: data.error,
          entitlement: data.respond_to?(:entitlement) ? data.entitlement : nil,
          feature_allocation: data.respond_to?(:feature_allocation) ? data.feature_allocation : nil,
          feature_usage: data.respond_to?(:feature_usage) ? data.feature_usage : nil,
          feature_usage_event: data.respond_to?(:feature_usage_event) ? data.feature_usage_event : nil,
          feature_usage_period: data.respond_to?(:feature_usage_period) ? data.feature_usage_period : nil,
          feature_usage_reset_at: data.respond_to?(:feature_usage_reset_at) ? data.feature_usage_reset_at : nil
        )

        # Cache the response
        @flag_check_cache_providers.each do |provider|
          provider.set(cache_key, response)
        end

        response
      rescue StandardError => e
        @logger.error("API flag check failed for '#{flag_key}': #{e.message}")
        CheckFlagResponse.new(
          value: get_flag_default(flag_key),
          flag_key: flag_key,
          reason: "error: #{e.message}"
        )
      end
    end

    def get_flag_default(flag_key)
      @flag_defaults_mutex.synchronize do
        @flag_defaults.fetch(flag_key, false)
      end
    end

    def build_cache_key(flag_key, company, user)
      parts = ["f:#{flag_key}"]

      if company&.any?
        company.sort_by { |k, _| k.to_s }.each do |k, v|
          parts << "c:#{k}:#{v}"
        end
      end

      if user&.any?
        user.sort_by { |k, _| k.to_s }.each do |k, v|
          parts << "u:#{k}:#{v}"
        end
      end

      parts.join(";")
    end

    def build_eval_context(company, user)
      ctx = {}
      ctx[:company] = company if company&.any?
      ctx[:user] = user if user&.any?
      ctx
    end

    # Try evaluating all keys via DataStream. Returns results array on success,
    # or nil if any flag can't be evaluated (caller should fall back to API).
    def check_flags_via_datastream(keys, company, user)
      eval_ctx = build_eval_context(company, user)
      results = []

      keys.each do |key|
        result = @datastream_client.check_flag(eval_ctx, key)
        response = CheckFlagResponse.new(result)
        enqueue_flag_check_event(key, response, company, user)
        results << { flag: key, value: response.value, reason: response.reason }
      rescue DataStream::EvaluationError => e
        @logger.debug("DataStream check_flags falling back to API: #{e.message}")
        return nil
      rescue StandardError => e
        @logger.warn("DataStream check_flags failed, falling back to API: #{e.message}")
        return nil
      end

      @logger.debug("All #{keys.length} flags evaluated via DataStream")
      results
    end

    def enqueue_flag_check_event(flag_key, response, company, user)
      body = {
        flag_key: flag_key,
        value: response.value,
        reason: response.reason
      }
      body[:flag_id] = response.flag_id if response.flag_id
      body[:rule_id] = response.rule_id if response.rule_id
      body[:company_id] = response.company_id if response.company_id
      body[:user_id] = response.user_id if response.user_id
      body[:company] = company if company&.any?
      body[:user] = user if user&.any?

      @event_buffer.push({
                           event_type: "flag_check",
                           body: body,
                           sent_at: Time.now.utc.iso8601
                         })
    end

    def setup_datastream(options)
      @rules_engine = RulesEngine.new(logger: @logger)

      ds_opts = {
        api_key: @api_key,
        base_url: @base_url,
        logger: @logger,
        rules_engine: @rules_engine,
        cache_ttl: options[:cache_ttl] || DataStream::DEFAULT_CACHE_TTL,
        replicator_mode: options[:replicator_mode] || false,
        replicator_health_url: options[:replicator_health_url] || DataStream::REPLICATOR_HEALTH_URL,
        replicator_health_interval: options[:replicator_health_interval] || DataStream::REPLICATOR_HEALTH_INTERVAL
      }

      # Redis client convenience — auto-creates Redis cache providers
      ds_opts[:redis_client] = options[:redis_client] if options[:redis_client]
      ds_opts[:redis_key_prefix] = options[:redis_key_prefix] if options[:redis_key_prefix]

      # Pass through custom cache providers if supplied
      ds_opts[:company_cache] = options[:company_cache] if options[:company_cache]
      ds_opts[:user_cache] = options[:user_cache] if options[:user_cache]
      ds_opts[:flag_cache] = options[:flag_cache] if options[:flag_cache]

      @datastream_client = DataStream::Client.new(**ds_opts)

      begin
        @datastream_client.start
      rescue StandardError => e
        @logger.error("Failed to start DataStream: #{e.message}")
        @datastream_client = nil
      end
    end
  end
end
