# frozen_string_literal: true

require "json"
require "net/http"

module Schematic
  module DataStream
    DEFAULT_CACHE_TTL = 86_400           # 24 hours in seconds
    MAX_CACHE_TTL = 30 * 86_400          # 30 days in seconds
    DEFAULT_CACHE_SIZE = 1000
    RESOURCE_TIMEOUT = 30                # seconds
    REPLICATOR_HEALTH_URL = "http://localhost:8090/ready"
    REPLICATOR_HEALTH_INTERVAL = 30      # seconds

    # Raised when DataStream cannot definitively evaluate a flag, signaling the
    # caller should fall back to the API path.
    class EvaluationError < StandardError; end

    class Client
      def initialize(
        api_key:,
        base_url:,
        logger:,
        rules_engine:,
        cache_ttl: DEFAULT_CACHE_TTL,
        company_cache: nil,
        user_cache: nil,
        flag_cache: nil,
        redis_client: nil,
        redis_key_prefix: "schematic:",
        replicator_mode: false,
        replicator_health_url: REPLICATOR_HEALTH_URL,
        replicator_health_interval: REPLICATOR_HEALTH_INTERVAL
      )
        @api_key = api_key
        @base_url = base_url
        @logger = logger
        @rules_engine = rules_engine
        @cache_ttl = cache_ttl
        @replicator_mode = replicator_mode
        @replicator_health_url = replicator_health_url
        @replicator_health_interval = replicator_health_interval
        @replicator_ready = false
        @cache_version = ""
        @mutex = Mutex.new
        @stopped = false

        if @replicator_mode
          has_shared_cache = redis_client || [company_cache, user_cache, flag_cache].compact.any?
          unless has_shared_cache
            raise ArgumentError,
                  "Replicator mode requires a shared cache provider (e.g. Redis). " \
                  "Pass redis_client: or provide company_cache:, user_cache:, flag_cache: with a shared cache implementation."
          end

          explicit_caches = [company_cache, user_cache, flag_cache].compact
          if explicit_caches.grep(Schematic::LocalCache).any?
            raise ArgumentError,
                  "Replicator mode requires a shared (distributed) cache provider, but received LocalCache. " \
                  "Use a shared cache implementation such as RedisCacheProvider."
          end
        end

        # Track internally-created caches so we can stop their cleanup threads
        @owned_caches = []

        # Entity caches — priority: custom provider > Redis client > LocalCache
        flag_ttl = [MAX_CACHE_TTL, cache_ttl].max
        company_primary = company_cache || build_cache_provider(redis_client, redis_key_prefix, cache_ttl)
        user_primary = user_cache || build_cache_provider(redis_client, redis_key_prefix, cache_ttl)
        flag_primary = flag_cache || build_cache_provider(redis_client, redis_key_prefix, flag_ttl)

        # Lookup caches (key→ID mappings) — use Redis when available so
        # replicator instances share lookup state, otherwise LocalCache.
        company_lookup = build_cache_provider(redis_client, redis_key_prefix, cache_ttl)
        user_lookup = build_cache_provider(redis_client, redis_key_prefix, cache_ttl)

        @company_cache = ResourceCache.new(
          primary_cache: company_primary,
          lookup_cache: company_lookup,
          key_prefix: "company",
          get_id: ->(c) { c[:id] || c["id"] },
          get_keys: ->(c) { c[:keys] || c["keys"] || {} }
        )

        @user_cache = ResourceCache.new(
          primary_cache: user_primary,
          lookup_cache: user_lookup,
          key_prefix: "user",
          get_id: ->(u) { u[:id] || u["id"] },
          get_keys: ->(u) { u[:keys] || u["keys"] || {} }
        )

        @flag_cache = flag_primary

        # Pending requests for deduplication
        @pending_companies = {} # cache_key => [ConditionVariable, ...]
        @pending_users = {}
        @pending_flags = nil
        @pending_mutex = Mutex.new

        @ws_client = nil
        @health_thread = nil
      end

      def start
        @logger.info("Starting DataStream client")
        @rules_engine&.initialize!

        # Set cache version from rules engine so cache keys include the WASM version.
        # In replicator mode this is overwritten by the replicator health check response.
        update_cache_version(@rules_engine.version_key) if @rules_engine&.initialized?

        if @replicator_mode
          @logger.info("Replicator mode enabled - skipping WebSocket connection")
          start_health_check
        else
          @ws_client = WebSocketClient.new(
            base_url: @base_url,
            api_key: @api_key,
            logger: @logger,
            message_handler: method(:handle_message),
            ready_handler: method(:handle_ready)
          )
          @ws_client.start
        end
      end

      def connected?
        @replicator_mode ? @replicator_ready : (@ws_client&.connected || false)
      end

      def close
        @logger.info("Closing DataStream client")
        @mutex.synchronize { @stopped = true }
        @ws_client&.close
        @health_thread&.join(5)
        @owned_caches.each { |c| c.stop if c.respond_to?(:stop) }
        @logger.info("DataStream client closed")
      end

      # Evaluate a flag using cached DataStream data and the local rules engine.
      # Raises DataStream::EvaluationError when the flag cannot be evaluated
      # locally (e.g. flag not in cache, rules engine unavailable), so the caller
      # can fall back to the API path.
      def check_flag(eval_ctx, flag_key)
        flag = get_flag(flag_key)
        raise EvaluationError, "flag '#{flag_key}' not found in cache" unless flag

        unless @rules_engine&.initialized?
          @logger.warn("Rules engine not initialized, using default flag value")
          raise EvaluationError, "rules engine not available"
        end

        company = nil
        user = nil

        company_keys = eval_ctx[:company] || eval_ctx["company"]
        user_keys = eval_ctx[:user] || eval_ctx["user"]

        if company_keys&.any?
          company = get_company(company_keys)
          @logger.debug("Company #{company ? "found in cache" : "not found in cache"} for keys: #{company_keys}")
        end

        if user_keys&.any?
          user = get_user(user_keys)
          @logger.debug("User #{user ? "found in cache" : "not found in cache"} for keys: #{user_keys}")
        end

        @logger.debug("Evaluating flag with rules engine: flag=#{flag_key}, company=#{company&.dig(:id)}, user=#{user&.dig(:id)}")
        result = @rules_engine.check_flag(flag, company, user)
        @logger.debug("Rules engine evaluation result: value=#{result[:value]}, reason=#{result[:reason]}")
        result[:flag_key] = flag_key
        result
      end

      def update_company_metrics(company_keys, event_name, quantity)
        company = @company_cache.get_by_keys(company_keys)
        return unless company

        company = Merge.deep_copy(company)
        metrics = company[:metrics] || company["metrics"] || []

        metrics.each do |metric|
          subtype = metric[:event_subtype] || metric["event_subtype"]
          next unless subtype == event_name

          current = metric[:value] || metric["value"] || 0
          metric[:value] = current + (quantity || 1)
        end

        company[:metrics] = metrics
        @company_cache.cache_entity(company, ttl: @cache_ttl)
      end

      private

      def update_cache_version(version)
        return if version == @cache_version

        @cache_version = version.to_s
        @company_cache.cache_version = @cache_version
        @user_cache.cache_version = @cache_version
        @logger.info("Cache version updated: #{@cache_version}")
      end

      def flag_cache_key(flag_key)
        "flags:#{@cache_version}:#{flag_key}"
      end

      def build_cache_provider(redis_client, redis_key_prefix, ttl)
        cache = if redis_client
                  Schematic::RedisCacheProvider.new(client: redis_client, ttl: ttl, key_prefix: redis_key_prefix)
                else
                  Schematic::LocalCache.new(max_size: DEFAULT_CACHE_SIZE, ttl: ttl)
                end
        @owned_caches << cache
        cache
      end

      def get_flag(flag_key)
        @flag_cache.get(flag_cache_key(flag_key))
      end

      def get_company(keys)
        cached = @company_cache.get_by_keys(keys)
        return cached if cached

        return nil if @replicator_mode

        request_entity(ENTITY_TYPE_COMPANY, keys, @pending_companies) do |_data|
          @company_cache.get_by_keys(keys)
        end
      end

      def get_user(keys)
        cached = @user_cache.get_by_keys(keys)
        return cached if cached

        return nil if @replicator_mode

        request_entity(ENTITY_TYPE_USER, keys, @pending_users) do |_data|
          @user_cache.get_by_keys(keys)
        end
      end

      def request_entity(entity_type, keys, pending_map, &after_receive)
        cache_key = "#{entity_type}:#{keys.sort.map { |k, v| "#{k}=#{v}" }.join(";")}"

        cv = ConditionVariable.new
        first_request = false

        @pending_mutex.synchronize do
          if pending_map[cache_key]
            pending_map[cache_key] << cv
          else
            pending_map[cache_key] = [cv]
            first_request = true
          end
        end

        if first_request
          @ws_client&.send_message({
                                     data: { entity_type: entity_type, keys: keys }
                                   })
        end

        # Wait for response with timeout
        result = nil
        @pending_mutex.synchronize do
          cv.wait(@pending_mutex, RESOURCE_TIMEOUT)
          result = after_receive&.call(nil)
        end

        result
      ensure
        @pending_mutex.synchronize do
          waiters = pending_map[cache_key]
          if waiters
            waiters.delete(cv)
            pending_map.delete(cache_key) if waiters.empty?
          end
        end
      end

      def handle_ready
        @logger.info("DataStream connection is ready")
        @logger.debug("Requesting initial flag data")
        @ws_client&.send_message({
                                   data: { entity_type: ENTITY_TYPE_FLAGS }
                                 })
      end

      def handle_message(message)
        entity_type = message[:entity_type] || message["entity_type"]
        message_type = message[:message_type] || message["message_type"]
        entity_id = message[:entity_id] || message["entity_id"]
        data = message[:data] || message["data"]

        @logger.debug("Processing DataStream message: EntityType=#{entity_type}, MessageType=#{message_type}")

        case entity_type
        when ENTITY_TYPE_FLAGS
          handle_flags_message(data, message_type)
        when ENTITY_TYPE_FLAG
          handle_flag_message(data, message_type)
        when ENTITY_TYPE_COMPANY, ENTITY_TYPE_COMPANIES
          handle_company_message(data, message_type, entity_id)
        when ENTITY_TYPE_USER, ENTITY_TYPE_USERS
          handle_user_message(data, message_type, entity_id)
        else
          if message[:error] || message["error"]
            handle_error_message(message)
          else
            @logger.warn("Unknown DataStream entity type: #{entity_type}")
          end
        end
      rescue StandardError => e
        @logger.error("Error handling DataStream message: #{e.message}")
      end

      def handle_flags_message(data, _message_type)
        unless data.is_a?(Array)
          @logger.warn("Expected flags array in bulk flags message")
          return
        end

        keys_to_keep = []
        data.each do |flag_data|
          flag_key = flag_data[:key] || flag_data["key"]
          next unless flag_key

          versioned_key = flag_cache_key(flag_key)
          @flag_cache.set(versioned_key, flag_data, ttl: [MAX_CACHE_TTL, @cache_ttl].max)
          keys_to_keep << versioned_key
        end

        @flag_cache.delete_missing(keys_to_keep, scope: "flags:") if @flag_cache.respond_to?(:delete_missing)

        @logger.debug("Cached #{data.size} flags from DataStream")

        notify_pending_flags
      end

      def handle_flag_message(data, message_type)
        flag_key = data[:key] || data["key"]
        return unless flag_key

        versioned_key = flag_cache_key(flag_key)
        case message_type
        when MESSAGE_TYPE_DELETE
          @flag_cache.delete(versioned_key)
        when MESSAGE_TYPE_FULL
          @flag_cache.set(versioned_key, data, ttl: [MAX_CACHE_TTL, @cache_ttl].max)
        else
          @logger.warn("Unexpected flag message type: #{message_type}")
        end
      end

      def handle_company_message(data, message_type, entity_id = nil)
        case message_type
        when MESSAGE_TYPE_DELETE
          delete_id = data[:id] || data["id"] if data.is_a?(Hash)
          @company_cache.delete_entity(data) if delete_id
        when MESSAGE_TYPE_PARTIAL
          # Cache lookup uses envelope entity_id; data is the wrapped partial
          # payload (e.g. {"credit_balances": {...}}), with no top-level id.
          if entity_id
            existing = @company_cache.get_by_id(entity_id)
            if existing
              merged = Merge.partial_company(existing, data)
              @company_cache.cache_entity(merged, ttl: @cache_ttl)
            else
              @logger.warn("Cache miss for partial company '#{entity_id}', skipping")
            end
          else
            @logger.warn("Partial company message missing entity_id")
          end
        when MESSAGE_TYPE_FULL
          full_id = data[:id] || data["id"] if data.is_a?(Hash)
          @company_cache.cache_entity(data, ttl: @cache_ttl) if full_id
        end

        notify_pending(:company, data)
      rescue StandardError => e
        @logger.error("Failed to process company message: #{e.message}")
      end

      def handle_user_message(data, message_type, entity_id = nil)
        case message_type
        when MESSAGE_TYPE_DELETE
          delete_id = data[:id] || data["id"] if data.is_a?(Hash)
          @user_cache.delete_entity(data) if delete_id
        when MESSAGE_TYPE_PARTIAL
          # Cache lookup uses envelope entity_id; data is the wrapped partial
          # payload with no top-level id.
          if entity_id
            existing = @user_cache.get_by_id(entity_id)
            if existing
              merged = Merge.partial_user(existing, data)
              @user_cache.cache_entity(merged, ttl: @cache_ttl)
            else
              @logger.warn("Cache miss for partial user '#{entity_id}', skipping")
            end
          else
            @logger.warn("Partial user message missing entity_id")
          end
        when MESSAGE_TYPE_FULL
          full_id = data[:id] || data["id"] if data.is_a?(Hash)
          @user_cache.cache_entity(data, ttl: @cache_ttl) if full_id
        end

        notify_pending(:user, data)
      rescue StandardError => e
        @logger.error("Failed to process user message: #{e.message}")
      end

      def handle_error_message(message)
        error = message[:error] || message["error"]
        @logger.error("DataStream error: #{error}")

        entity_type = message[:entity_type] || message["entity_type"]
        case entity_type
        when ENTITY_TYPE_COMPANY, ENTITY_TYPE_COMPANIES
          notify_pending(:company, nil)
        when ENTITY_TYPE_USER, ENTITY_TYPE_USERS
          notify_pending(:user, nil)
        end
      end

      def notify_pending(type, data)
        pending_map = type == :company ? @pending_companies : @pending_users
        @pending_mutex.synchronize do
          if data
            # Try to wake only the waiters matching this entity's keys
            id = data[:id] || data["id"]
            entity_keys = data[:keys] || data["keys"] || {}
            matching_cache_keys = pending_map.keys.select do |ck|
              ck.include?(id.to_s) || entity_keys.any? { |k, v| ck.include?("#{k}=#{v}") }
            end
            if matching_cache_keys.any?
              matching_cache_keys.each do |ck|
                pending_map[ck]&.each(&:broadcast)
              end
            else
              # Can't determine match — wake all
              pending_map.each_value { |waiters| waiters.each(&:broadcast) }
            end
          else
            # Error or nil data — wake all waiters of this type
            pending_map.each_value { |waiters| waiters.each(&:broadcast) }
          end
        end
      end

      def notify_pending_flags
        @pending_mutex.synchronize do
          @pending_flags&.broadcast
        end
      end

      # --- Replicator Mode ---

      def start_health_check
        @logger.info("Starting replicator health check with URL: #{@replicator_health_url}, interval: #{@replicator_health_interval}s")
        check_replicator_health

        @health_thread = Thread.new do
          loop do
            sleep(@replicator_health_interval)
            break if @stopped

            check_replicator_health
          end
        end
        @health_thread.abort_on_exception = false
      end

      def check_replicator_health
        uri = URI.parse(@replicator_health_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"
        http.open_timeout = 5
        http.read_timeout = 5
        response = http.get(uri.request_uri)

        if response.is_a?(Net::HTTPSuccess)
          body = begin
            JSON.parse(response.body, symbolize_names: true)
          rescue StandardError
            {}
          end
          was_ready = @replicator_ready
          @replicator_ready = body[:ready] == true

          update_cache_version(body[:cache_version].to_s)

          @logger.info("Replicator is ready") if @replicator_ready && !was_ready
          @logger.info("Replicator is no longer ready") if !@replicator_ready && was_ready
        else
          was_ready = @replicator_ready
          @replicator_ready = false
          @logger.info("Replicator is no longer ready") if was_ready
          @logger.warn("Replicator health check failed: #{response.code}")
        end
      rescue StandardError => e
        was_ready = @replicator_ready
        @replicator_ready = false
        @logger.info("Replicator is no longer ready") if was_ready
        @logger.warn("Replicator health check error: #{e.message}")
      end
    end
  end
end
