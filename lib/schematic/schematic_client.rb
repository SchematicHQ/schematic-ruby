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

    # Optional event metadata accepted via the `options:` keyword on track/identify.
    # identify only honors :idempotency_key; track also honors :sent_at,
    # :trusted_client_clock, and :backfill. Fields are only sent when set.
    # Namespaces the idempotency key on the track event a reservation settles
    # into. Deterministic per reservation, so a recovery emit (the work outlived
    # the local reservation TTL) and an accidental double settle collapse to one
    # billed event: the pipeline drops duplicates for 24h before any credit
    # consumption runs.
    RESERVATION_TRACK_IDEMPOTENCY_PREFIX = "lease-reservation:"

    # Knobs that only steer the local lease plumbing, which server mode never
    # builds. Setting one there does nothing, so the client says so at startup.
    CLIENT_ONLY_LEASE_OPTIONS = %i[
      default_lease_duration default_lease_size low_water_mark sweep_interval_ms
      redis_client redis_key_prefix prewarm_resolve_timeout_ms overrides
    ].freeze

    TRACK_OPTION_KEYS = %i[idempotency_key sent_at trusted_client_clock backfill].freeze
    IDENTIFY_OPTION_KEYS = %i[idempotency_key].freeze

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
      credit_leases: nil,
      logger: nil,
      log_level: :warn
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

      # Credit lease + reservation plumbing, if the caller opted in.
      @credit_lease_config = nil
      @credit_lease_mode = nil
      @credit_lease_manager = nil
      @lease_store = nil
      @reservations = nil
      # True when lease state lives in a shared backend that sibling processes
      # may also be drawing on. close must then NOT release leases.
      @lease_backend_shared = false
      @server_reservation_ttl_ms = Credits::Leases::DEFAULT_RESERVATION_TTL_MS
      @prewarm_resolve_timeout_ms = Credits::Leases::DEFAULT_PREWARM_RESOLVE_TIMEOUT_MS
      # Prewarms identify spawned and nobody joins. close waits them out: an
      # acquire that lands after the release installs a lease nothing releases,
      # and its credits stay held until the server expires them.
      @pending_prewarms = []
      @pending_prewarms_mutex = Mutex.new
      @closing = false
      setup_credit_leases(credit_leases, datastream_options) if credit_leases

      # Register shutdown hook to ensure graceful cleanup on process exit
      at_exit { close }
    end

    # --- Flag Checking ---

    def check_flag(flag_key, company: nil, user: nil)
      check_flag_with_entitlement(flag_key, company: company, user: user).value
    end

    # default_value overrides the registered flag default on every path that
    # cannot answer from the flag itself: offline, an API error, or a response
    # with no value. Leaving it nil keeps the registered default. timeout_ms is
    # threaded to the API call, but see the note on check: the generated
    # transport does not yet apply a per-request timeout.
    def check_flag_with_entitlement(flag_key, company: nil, user: nil, preflight: nil, default_value: nil,
                                    timeout_ms: nil)
      get_default = -> { resolve_default_value(flag_key, default_value) }

      # Offline mode
      if @offline
        return CheckFlagResponse.new(
          value: get_default.call,
          flag_key: flag_key,
          reason: "offline mode"
        )
      end

      # DataStream path
      if @datastream_client&.connected?
        begin
          eval_ctx = build_eval_context(company, user)
          # Only widen the call when there is something to pass: a DataStream
          # double written against the two-argument form still works, and the
          # preflight envelope reaches the engine when a lease check supplies it.
          result = if preflight.nil?
                     @datastream_client.check_flag(eval_ctx, flag_key)
                   else
                     @datastream_client.check_flag(eval_ctx, flag_key, preflight)
                   end

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
      check_flag_via_api(flag_key, company, user, preflight: preflight, timeout_ms: timeout_ms,
                                                  get_default: get_default)
    rescue StandardError => e
      @logger.error("check_flag_with_entitlement error for '#{flag_key}': #{e.message}")
      CheckFlagResponse.new(
        value: get_default.call,
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
            cached = coerce_cached_response(provider.get(cache_key))
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

    # --- Credit-aware Flag Checking ---

    # Credit-aware feature check. With credit_leases configured and a usage
    # passed (optionally qualified by an event_subtype), this gates the check
    # against the company's credit balance and returns a reservation handle on
    # success. Hand that handle to track_with_reservation when the work
    # completes.
    #
    # In client mode (DataStream enabled) the hold is carved out of a local
    # lease and the flag is evaluated by the WASM engine. In server mode it is a
    # single check-and-reserve API call that evaluates the flag and takes the
    # hold server-side. credit_leases[:mode] picks; the default, :auto, uses
    # client mode when DataStream is enabled and server mode otherwise.
    #
    # Without credit_leases (or without a usage) this falls through to a plain
    # flag check and returns a result with no reservation. The caller's
    # preflight is still threaded through that plain check, so any client-side
    # evaluation path gates on the post-call balance, just without a
    # reservation, and the REST path sends the preflight too. default_value
    # governs that fallback too, so a check that cannot reach the credit path
    # still answers the way the caller asked.
    #
    # timeout_ms is carried on the API request but not yet applied: the
    # generated transport takes its timeout from the construction of its HTTP
    # client, and nothing exposes that, so no per-check or client-level timeout
    # is configurable today.
    def check(flag_key, company: nil, user: nil, usage: nil, event_subtype: nil, on_acquire_failure: nil,
              default_value: nil, timeout_ms: nil)
      options = {
        usage: usage,
        event_subtype: event_subtype,
        on_acquire_failure: on_acquire_failure,
        default_value: default_value,
        timeout_ms: timeout_ms
      }
      # The lease paths guard usage themselves; this one has to as well,
      # because a non-numeric usage reaches the preflight builder and a
      # negative or NaN one would size a preflight the engine cannot use. Ruby
      # has no type to catch it at the boundary the way the other SDKs do.
      if !usage.nil? && !Credits::Leases.valid_quantity?(usage)
        @logger.warn(
          "check: invalid usage #{usage.inspect} for flag #{flag_key}, must be a finite non-negative " \
          "number; continuing without one"
        )
        options[:usage] = nil
        usage = nil
      end

      eval_ctx = build_eval_context(company, user)
      fallback = -> { plain_check_result(flag_key, company, user, options) }

      mode = effective_lease_mode
      return fallback.call if usage.nil? || mode.nil?

      if mode == :server
        return Credits::Leases.check_with_server_reservation(
          Credits::Leases::ServerCheckDeps.new(
            features: features, credits: credits, logger: @logger,
            reservation_ttl_ms: @server_reservation_ttl_ms,
            default_value: -> { resolve_default_value(flag_key, default_value) }
          ),
          flag_key, eval_ctx, options, &fallback
        )
      end

      # Client mode without the local plumbing (mode: :client and no DataStream)
      # keeps the old behavior: a plain, ungated flag check.
      return fallback.call unless @credit_lease_manager && @lease_store && @reservations

      Credits::Leases.check_with_lease(
        Credits::Leases::CheckDeps.new(
          lease_store: @lease_store, reservations: @reservations, manager: @credit_lease_manager,
          datastream: @datastream_client, logger: @logger,
          # Lease-path checks must stay visible to flag-check analytics and
          # company last-seen, the same as every plain check path.
          enqueue_flag_check_event: ->(body) { enqueue_lease_flag_check_event(body) }
        ),
        flag_key, eval_ctx, options, &fallback
      )
    end

    # Consume a reservation issued by check. Refunds the unused slice back to
    # the lease's local balance and enqueues a track event with the actual
    # quantity; the server-side event processor consumes
    # actual_quantity x consumption_rate from the company's real credit balance.
    #
    # A server-mode handle has no local hold to refund: the track event carries
    # the reservation id, and the server settles the hold when it processes the
    # event.
    #
    # If the work outlived the reservation's TTL and the sweeper already
    # returned the hold to the lease, the local refund has happened but the
    # usage must still be billed, so the track is emitted anyway as a recovery
    # emit. Double billing is prevented server-side: the track carries a
    # deterministic idempotency key derived from the reservation id, and the
    # events pipeline drops duplicates for 24h before any credit consumption
    # runs. So a recovery emit racing the normal emit, or an accidental second
    # settle, collapses to a single billed event, across processes and restarts.
    def track_with_reservation(reservation, actual_quantity, traits: nil)
      return if @offline

      # check allows without a hold in several ordinary cases: the feature is
      # not credit-metered, the check failed open, usage was 0, or credit leases
      # are not configured. Callers pass result.reservation straight through, so
      # take the nil and tell them how to bill the usage instead of raising on a
      # settle that has nothing to settle.
      if reservation.nil?
        @logger.error(
          "track_with_reservation called without a reservation: the check allowed without taking a hold, " \
          "so there is nothing to settle. Report the usage with track instead."
        )
        return
      end

      # Mirror the check-path usage guard: a non-finite quantity must reach
      # neither the store (clamping against NaN claims the reservation with NO
      # refund of the unspent slice) nor the billing event, and a negative one
      # would bill negative usage. Skipping the settle leaves the reservation to
      # expire at its TTL, where the sweeper refunds the full hold, so no
      # credits are lost and nothing bogus is billed.
      unless Credits::Leases.valid_quantity?(actual_quantity)
        @logger.error(
          "track_with_reservation: invalid actual_quantity #{actual_quantity.inspect} for reservation " \
          "#{reservation.id}, must be a finite non-negative number; skipping settle " \
          "(the hold is refunded at its TTL)"
        )
        return
      end

      settle_reservation(reservation, actual_quantity, traits)
    end

    # Pre-warm a credit lease for each given credit type id, so the first check
    # against it does not pay the acquire round trip. Failures are logged, never
    # raised.
    #
    # When the company carries only secondary keys (no id), prewarm actively
    # fetches it over the datastream, waiting up to
    # credit_leases[:prewarm_resolve_timeout_ms], which both resolves the id and
    # warms the cache so the first check hits the lease path.
    def prewarm(credit_type_ids, company: nil)
      if @credit_lease_manager.nil? || @lease_store.nil?
        @logger.debug(
          effective_lease_mode == :server ? "prewarm is a no-op in server mode, there is no local lease to warm" : "prewarm called but credit_leases is not configured"
        )
        return
      end
      if company.nil? || company.empty?
        @logger.debug("prewarm requires a company")
        return
      end
      # Documented as never raising, and a caller reading ids out of config can
      # hand over nil or an empty list without meaning to.
      if credit_type_ids.nil? || credit_type_ids.empty?
        @logger.debug("prewarm requires at least one credit type id")
        return
      end
      if @closing
        # close only waits out the prewarms it spawned; a caller invoking
        # prewarm directly would otherwise install a lease after the release has
        # already listed the store.
        @logger.debug("prewarm: client is closing, skipping acquire")
        return
      end

      company_id = resolve_company_id_with_wait(company)
      if company_id.nil?
        @logger.debug(
          "prewarm: company not resolved within #{@prewarm_resolve_timeout_ms}ms for keys #{company} " \
          "(first check will acquire)"
        )
        return
      end

      credit_type_ids.each do |credit_type_id|
        @credit_lease_manager.acquire_if_needed(company_id, credit_type_id)
      rescue StandardError => e
        @logger.warn("prewarm: failed to acquire lease for #{credit_type_id}: #{e.message}")
      end
      nil
    end

    # --- Event Submission ---

    # prewarm names credit type ids to acquire leases for in the background once
    # the identify event is enqueued. Failures never surface to the caller, and
    # it is a no-op unless credit_leases is configured.
    def identify(body, options: nil, prewarm: nil)
      return if @offline

      begin
        @event_buffer.push(build_event("identify", body, options, IDENTIFY_OPTION_KEYS))
      rescue StandardError => e
        @logger.error("Error sending identify event: #{e.message}")
      end

      return if prewarm.nil? || prewarm.empty?

      begin
        prewarm_after_identify(body, prewarm)
      rescue StandardError => e
        # identify never raises into its caller, and a prewarm is the least of
        # the reasons it should start.
        @logger.warn("identify prewarm setup failed: #{e.message}")
      end
    end

    def track(body, options: nil)
      return if @offline

      @event_buffer.push(build_event("track", body, options, TRACK_OPTION_KEYS))

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

    # Credit leases: with the per-process in-memory backend this process is the
    # only holder of its leases, so they are released here (best-effort), which
    # returns their unspent remainder to the company balance immediately instead
    # of waiting out the lease expiry. With a shared backend, leases are
    # deliberately NOT released: one row per company and credit is shared across
    # every SDK instance pointed at that backend, so a single process shutting
    # down must not release a lease its siblings are still drawing on. Shared
    # leases reclaim themselves by expiring or being fully consumed.
    #
    # Lease work already in flight is waited out, bounded, before the release,
    # so an acquire that lands mid-shutdown is one the release can see.
    def close
      return if @closed

      @closed = true
      @closing = true
      shut_down_credit_leases
      @event_buffer.stop
      @datastream_client&.close
      @flag_check_cache_providers.each { |c| c.stop if c.respond_to?(:stop) }
      @logger.debug("SchematicClient closed")
    end

    private

    # --- Internal Flag Checking ---

    # Cache providers that serialize (RedisCacheProvider) hand back a Hash, not
    # the CheckFlagResponse that was stored; the in-memory cache returns the
    # object itself. Normalize so callers can use the response API either way.
    def coerce_cached_response(cached)
      return cached unless cached.is_a?(Hash)

      CheckFlagResponse.new(cached)
    end

    def check_flag_via_api(flag_key, company, user, preflight: nil, timeout_ms: nil, get_default: nil)
      get_default ||= -> { get_flag_default(flag_key) }
      cache_key = build_cache_key(flag_key, company, user)
      # The cache is keyed by flag, company and user, so a preflighted check and
      # a plain one collide on one entry while asking different questions ("is
      # this allowed after the action" versus "is it allowed now"). A
      # preflighted check therefore neither reads the cache nor writes to it.
      if preflight.nil?
        @flag_check_cache_providers.each do |provider|
          cached = coerce_cached_response(provider.get(cache_key))
          if cached
            @logger.debug("Flag '#{flag_key}' found in cache (value=#{cached.value})")
            return cached
          end
        end
      end

      # Call API
      begin
        @logger.debug("Flag '#{flag_key}' not in cache, calling API")
        eval_body = {}
        eval_body[:company] = company if company&.any?
        eval_body[:user] = user if user&.any?
        eval_body[:preflight] = preflight if preflight

        api_response = @api_client.features.check_flag(
          request_options: api_request_options(timeout_ms), key: flag_key, **eval_body
        )
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

        # Cache the response, unless the verdict was preflighted: it answers a
        # question a later plain check is not asking.
        if preflight.nil?
          @flag_check_cache_providers.each do |provider|
            provider.set(cache_key, response)
          end
        end

        response
      rescue StandardError => e
        @logger.error("API flag check failed for '#{flag_key}': #{e.message}")
        CheckFlagResponse.new(
          value: get_default.call,
          flag_key: flag_key,
          reason: "error: #{e.message}"
        )
      end
    end

    # The generated transport reads its timeout from its own construction, not
    # from a request, so timeout_in_seconds is carried but not yet honored.
    # Sending it anyway means a per-check timeout starts working the moment the
    # transport does, without another change here.
    def api_request_options(timeout_ms)
      return {} if timeout_ms.nil?

      { timeout_in_seconds: timeout_ms / 1000.0 }
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

    # Build the buffered event hash, applying any caller-supplied options.
    # Only keys in allowed_keys are honored, and only when explicitly set, so
    # unset fields never appear on the wire.
    def build_event(event_type, body, options, allowed_keys)
      event = {
        event_type: event_type,
        body: body,
        sent_at: Time.now.utc.iso8601
      }
      return event unless options.is_a?(Hash)

      allowed_keys.each do |key|
        value = option_value(options, key)
        next if value.nil?

        event[key] = key == :sent_at ? normalize_sent_at(value) : value
      end

      event
    end

    def option_value(options, key)
      return options[key] if options.key?(key)

      options[key.to_s]
    end

    def normalize_sent_at(value)
      return value if value.is_a?(String)
      return value.utc.iso8601 if value.respond_to?(:utc)
      return value.iso8601 if value.respond_to?(:iso8601)

      value
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

    # --- Credit Leases ---

    def setup_credit_leases(config, datastream_options)
      config = normalize_credit_lease_config(config)
      if @offline
        @logger.warn(
          "credit_leases is configured but the client is in offline mode; lease-gated checks are disabled " \
          "and check will return flag defaults with no credit gating."
        )
        return
      end

      validate_credit_lease_config(config)
      @credit_lease_config = config
      @credit_lease_mode = config[:mode] || :auto
      resolve_server_reservation_ttl(config)
      warn_about_mode(config)
      return unless credit_lease_mode_uses_leases?

      build_lease_plumbing(config, datastream_options)
    end

    # Reject a knob that cannot mean anything, at construction, where the stack
    # still points at the caller. Left to run, a zero sweep interval spins a
    # thread flat out, a non-positive lease size or duration acquires a lease
    # nothing can reserve against, and a water mark outside (0, 1) either never
    # extends or extends on every check.
    def validate_credit_lease_config(config)
      %i[default_lease_duration default_reservation_ttl default_lease_size sweep_interval_ms
         prewarm_resolve_timeout_ms].each do |knob|
        # prewarm_resolve_timeout_ms documents 0 as cache-only, so it alone may
        # be zero.
        validate_positive_number(config, knob, allow_zero: knob == :prewarm_resolve_timeout_ms)
      end
      validate_low_water_mark(config)
      (config[:overrides] || {}).each_value { |override| validate_credit_lease_config(override) }
      nil
    end

    def validate_positive_number(config, knob, allow_zero: false)
      value = config[knob]
      return if value.nil?

      # finite? rejects NaN and both infinities, neither of which can size a
      # lease, a sweep, or a timeout.
      valid = value.is_a?(Numeric) && value.to_f.finite? && (allow_zero ? value >= 0 : value.positive?)
      return if valid

      raise ArgumentError,
            "credit_leases[:#{knob}] must be a finite #{allow_zero ? "non-negative" : "positive"} number, " \
            "got #{value.inspect}"
    end

    def validate_low_water_mark(config)
      value = config[:low_water_mark]
      return if value.nil?
      return if value.is_a?(Numeric) && value.to_f.finite? && value.positive? && value < 1

      raise ArgumentError, "credit_leases[:low_water_mark] must be a number between 0 and 1, got #{value.inspect}"
    end

    # Accept the hyphenated spellings the other SDKs use for the two enum-ish
    # knobs, so one config shape travels across a mixed fleet.
    def normalize_credit_lease_config(config)
      normalized = config.transform_keys(&:to_sym)
      normalized[:mode] = resolve_credit_lease_mode(normalized[:mode])
      normalized
    end

    # An unrecognized mode must not read as :auto in silence: the branches test
    # for :client and :server and everything else falls through, so a typo would
    # quietly pick a mode the caller did not ask for. Name the value, then use
    # the documented default.
    def resolve_credit_lease_mode(value)
      return :auto if value.nil?

      mode = Credits::Leases.normalize_symbol(value)
      return mode if Credits::Leases::MODES.include?(mode)

      @logger.warn(
        "Unrecognized credit_leases[:mode] #{value.inspect}; expected one of " \
        "#{Credits::Leases::MODES.join(", ")}. Using :auto."
      )
      :auto
    end

    # The API refuses a hold expiring more than an hour after its own clock, and
    # this TTL is applied to the caller's, so clamp a step below the cap to leave
    # room for skew. Only server mode sends the value to the API: in client mode
    # it sizes the local sweep, so clamping there would shorten holds for no
    # reason and the warning would be untrue.
    def resolve_server_reservation_ttl(config)
      configured = config[:default_reservation_ttl] || Credits::Leases::DEFAULT_RESERVATION_TTL_MS
      max_ttl = Credits::Leases::MAX_RESERVATION_TTL_MS - Credits::Leases::RESERVATION_TTL_SKEW_ALLOWANCE_MS
      @server_reservation_ttl_ms = @credit_lease_mode == :client ? configured : [configured, max_ttl].min
      return unless @credit_lease_mode != :client && configured > max_ttl

      @logger.warn(
        "credit_leases[:default_reservation_ttl] of #{configured}ms is longer than the API will hold credits " \
        "for; server-mode holds will be clamped to #{max_ttl}ms (the " \
        "#{Credits::Leases::MAX_RESERVATION_TTL_MS}ms maximum, less " \
        "#{Credits::Leases::RESERVATION_TTL_SKEW_ALLOWANCE_MS}ms of room for clock skew)."
      )
    end

    def warn_about_mode(config)
      # Server mode holds credits over the API, so none of the local lease
      # plumbing is built and options that only steer it would silently do
      # nothing. Say so once, at startup. :auto with no DataStream lands in
      # server mode too, and is the likelier way to get here.
      if @credit_lease_mode == :server || (@credit_lease_mode == :auto && @datastream_client.nil?)
        client_only = CLIENT_ONLY_LEASE_OPTIONS.reject { |name| config[name].nil? }
        if client_only.any?
          @logger.warn(
            "credit_leases resolves to server mode, so #{client_only.join(", ")} will be ignored: " \
            "those options only apply to client mode (local leases over DataStream)."
          )
        end
      end

      # :auto with no DataStream is the server-mode default, not a
      # misconfiguration: check-and-reserve gates over the API instead. :client
      # without DataStream is the degraded path, where every check falls back to
      # a plain flag check with usage ignored, so it warns.
      if @credit_lease_mode == :auto && @datastream_client.nil?
        @logger.info(
          "credit_leases is configured and DataStream is not enabled; credit reservations will run in server " \
          "mode (one check-and-reserve API call per check). Set use_data_stream: true (or replicator mode) " \
          "for client-side leases."
        )
      end
      return unless @credit_lease_mode == :client && @datastream_client.nil?

      @logger.warn(
        "credit_leases is configured but DataStream is not enabled; check will fall back to plain flag checks " \
        "with NO credit gating (usage is ignored). Set use_data_stream: true (or replicator mode) to enable " \
        "lease-gated checks."
      )
    end

    def build_lease_plumbing(config, datastream_options)
      sweep_ms = config[:sweep_interval_ms] || Credits::Leases::DEFAULT_SWEEP_INTERVAL_MS
      # Lease and reservation state belongs in a shared cache so gating holds
      # across horizontally scaled processes. Prefer an explicit client, but
      # otherwise reuse the one the DataStream cache is already configured with,
      # so an existing Redis setup backs leases automatically. Same for the key
      # prefix.
      redis_client = config[:redis_client] || datastream_options[:redis_client]
      key_prefix = config[:redis_key_prefix] || datastream_options[:redis_key_prefix]

      if redis_client
        # Shared-state backend: the lease balance and the reservation table live
        # in Redis, and the Lua-driven reserve and consume paths give atomic
        # cross-process gating without a separate lock service.
        @lease_backend_shared = true
        @lease_store = Credits::Leases::RedisLeaseStore.new(
          client: redis_client, key_prefix: key_prefix,
          default_lease_duration_ms: config[:default_lease_duration] || Credits::Leases::DEFAULT_LEASE_DURATION_MS
        )
        @reservations = Credits::Leases::RedisReservationStore.new(
          client: redis_client, lease_store: @lease_store, sweep_interval_ms: sweep_ms,
          key_prefix: key_prefix, logger: @logger
        )
      else
        # No shared backend configured. In a horizontally scaled deployment each
        # process then acquires and gates against its own leases, which defeats
        # the cross-process over-spend protection that is the point of leasing,
        # so warn rather than degrade silently.
        @logger.warn(
          "credit_leases is enabled without a shared Redis backend; lease and reservation state will be kept " \
          "per-process. Configure datastream_options[:redis_client] (or credit_leases[:redis_client]) so " \
          "leases gate correctly across multiple SDK instances."
        )
        @lease_store = Credits::Leases::LeaseStore.new
        @reservations = Credits::Leases::ReservationStore.new(@lease_store, sweep_ms, logger: @logger)
      end

      @reservations.start_sweep
      @credit_lease_manager = Credits::Leases::LeaseManager.new(
        wire_client: Credits::Leases::ApiWireClient.new(credits_client: credits),
        lease_store: @lease_store,
        logger: @logger,
        config: config
      )
      @prewarm_resolve_timeout_ms =
        config[:prewarm_resolve_timeout_ms] || Credits::Leases::DEFAULT_PREWARM_RESOLVE_TIMEOUT_MS
    end

    # Whether the configured mode wants the local lease plumbing. Read during
    # construction, after the DataStream client has been wired, so :auto can
    # resolve against it.
    def credit_lease_mode_uses_leases?
      return false if @credit_lease_mode.nil? || @credit_lease_mode == :server
      return true if @credit_lease_mode == :client

      !@datastream_client.nil?
    end

    # Which reservation mode a check with usage resolves to right now. Nil means
    # no credit gating at all: credit_leases is not configured, or the client is
    # offline.
    #
    # :auto is resolved per check rather than once at startup, so a DataStream
    # that failed to start after construction falls to server mode instead of
    # silently dropping every check to a plain, ungated flag check.
    def effective_lease_mode
      return nil if @credit_lease_mode.nil? || @offline
      return :server if @credit_lease_mode == :server
      return :client if @credit_lease_mode == :client

      plumbing_ready = !@credit_lease_manager.nil? && !@lease_store.nil? && !@reservations.nil?
      @datastream_client && plumbing_ready ? :client : :server
    end

    # The plain (non-lease) check the credit paths fall back to, with the
    # caller's preflight threaded through so a client-side evaluation still
    # gates on the post-call balance.
    def plain_check_result(flag_key, company, user, options)
      # The caller's default_value governs this path too. Without it a check
      # that falls back and then fails would answer with the registered flag
      # default, denying where the caller asked to allow.
      response = check_flag_with_entitlement(
        flag_key, company: company, user: user,
                  preflight: Credits::Leases.build_preflight_options(options),
                  default_value: options[:default_value], timeout_ms: options[:timeout_ms]
      )
      value = response.value
      Credits::Leases::CheckResult.new(
        allowed: value, value: value, reason: response.reason, entitlement: response.entitlement,
        flag_key: response.flag_key || flag_key, flag_id: response.flag_id, error: response.error
      )
    end

    def resolve_default_value(flag_key, default_value)
      return get_flag_default(flag_key) if default_value.nil?
      return default_value.call if default_value.respond_to?(:call)

      default_value
    end

    def enqueue_lease_flag_check_event(body)
      payload = {
        flag_key: body[:flag_key],
        value: body[:value],
        reason: body[:reason]
      }
      payload[:error] = body[:error] if body[:error]
      payload[:flag_id] = body[:flag_id] if body[:flag_id]
      payload[:rule_id] = body[:rule_id] if body[:rule_id]
      payload[:company_id] = body[:company_id] if body[:company_id]
      payload[:user_id] = body[:user_id] if body[:user_id]
      payload[:company] = body[:req_company] if body[:req_company]&.any?
      payload[:user] = body[:req_user] if body[:req_user]&.any?

      @event_buffer.push({ event_type: "flag_check", body: payload, sent_at: Time.now.utc.iso8601 })
    rescue StandardError => e
      @logger.error("Error enqueueing flag_check event: #{e.message}")
    end

    def settle_reservation(reservation, actual_quantity, traits)
      idempotency_key = "#{RESERVATION_TRACK_IDEMPOTENCY_PREFIX}#{reservation.id}"
      # Server mode: the hold lives on the server and settles by id, so there is
      # nothing local to consume or refund. Just emit the track.
      if reservation.server_mode? || @reservations.nil?
        @logger.warn("track_with_reservation called but credit_leases is not configured; emitting unsettled track") if @reservations.nil? && !reservation.server_mode?
        # Without a local store there is nothing to settle against, but the
        # billing event must still carry the lease id (the handle was issued by
        # a lease-configured client, and dropping it would double-debit the
        # grant) and the deterministic idempotency key.
        track(Credits::Leases.build_reservation_track_event(reservation, actual_quantity, traits: traits),
              options: { idempotency_key: idempotency_key })
        return
      end

      outcome = begin
        Credits::Leases.consume_reservation_and_build_event(@reservations, reservation, actual_quantity,
                                                            traits: traits)
      rescue StandardError => e
        # The local settle failed, most likely an unreachable Redis. The usage
        # still has to be billed: build the track from the caller-held handle
        # and emit it anyway. The unsettled local hold is reclaimed by the
        # sweeper at its TTL or at lease expiry, and the idempotency key keeps a
        # retried settle from double billing.
        @logger.warn(
          "track_with_reservation: failed to settle reservation #{reservation.id} locally (#{e.message}), " \
          "emitting track anyway"
        )
        Credits::Leases::SettleOutcome.new(
          track: Credits::Leases.build_reservation_track_event(reservation, actual_quantity, traits: traits),
          settled_locally: false
        )
      end

      unless outcome.settled_locally
        @logger.debug(
          "track_with_reservation: reservation #{reservation.id} was not settled locally (expired or swept, " \
          "already settled, or store unreachable), emitting track keyed for idempotent server-side dedupe"
        )
      end
      track(outcome.track, options: { idempotency_key: idempotency_key })
    end

    def prewarm_after_identify(body, credit_type_ids)
      # A thread that would only log "no-op in server mode" is still a thread,
      # and close still has to wait it out. Decide before spawning one.
      return nil if @credit_lease_manager.nil? || @lease_store.nil?

      company = identify_company_keys(body)

      thread = Thread.new do
        # Force a flush so the server processes the identify as soon as
        # possible. Without it the company may sit in the local buffer for up to
        # the flush interval before the server even sees it, and prewarm's
        # bounded poll would just be waiting on us. It runs here rather than on
        # the caller's thread because a flush is an HTTP post with retries, and
        # identify with a prewarm must stay the buffer push that identify
        # without one is. The ordering the poll needs still holds: the flush and
        # the poll are the same thread, in that order. close waits on this
        # thread, so a shutdown still covers the flush.
        begin
          @event_buffer.flush
        rescue StandardError => e
          @logger.debug("identify flush before prewarm failed: #{e.message}")
        end
        prewarm(credit_type_ids, company: company)
      rescue StandardError => e
        @logger.warn("identify prewarm failed: #{e.message}")
      end
      thread.abort_on_exception = false
      @pending_prewarms_mutex.synchronize do
        @pending_prewarms.select!(&:alive?)
        @pending_prewarms << thread
      end
      nil
    end

    # Like resolving a company id from the cache, but actively fetches the
    # company over the datastream when only secondary keys are supplied, warming
    # the cache as a side effect. Returns the id, or nil if the company never
    # surfaced within the timeout.
    #
    # identify does not push a company into the datastream cache: companies are
    # only streamed in response to a request. So this fetches rather than
    # passively polling the cache, which would watch an empty cache until it
    # times out. Fetching also primes the cache so the first real check hits the
    # lease path instead of falling back.
    def resolve_company_id_with_wait(company)
      return company[:id] || company["id"] if company[:id] || company["id"]
      return nil if @datastream_client.nil?

      cached = @datastream_client.get_cached_company(company)
      cached_id = cached && (cached[:id] || cached["id"])
      return cached_id if cached_id
      # A zero or negative timeout means cache-only: answer from what the
      # DataStream already holds and never fetch or poll. A prewarm still
      # acquires when an earlier check warmed the company.
      return nil if @prewarm_resolve_timeout_ms <= 0

      deadline = monotonic_ms + @prewarm_resolve_timeout_ms
      loop do
        # A company resolved for a client that is shutting down warms nothing,
        # and close would be waiting out the rest of this poll.
        return nil if @closing

        if @datastream_client.connected?
          resolved_id = fetch_company_id_within(company, deadline)
          return resolved_id if resolved_id
        else
          # A request sent over a closed socket is dropped without an error, so
          # the fetch would just sit out its own timeout. Poll the cache until
          # the socket returns or the budget runs out.
          cached = @datastream_client.get_cached_company(company)
          cached_id = cached && (cached[:id] || cached["id"])
          return cached_id if cached_id
        end
        return nil if monotonic_ms >= deadline

        sleep([Credits::Leases::DEFAULT_PREWARM_POLL_INTERVAL_MS, deadline - monotonic_ms].min / 1000.0)
      end
    end

    # A caller can hand identify any shape, so read the company keys without
    # assuming one.
    def identify_company_keys(body)
      return nil unless body.is_a?(Hash)

      company = body[:company] || body["company"]
      return nil unless company.is_a?(Hash)

      company[:keys] || company["keys"]
    end

    # get_company waits on the DataStream's own resource timeout, which is many
    # times the prewarm budget, so it runs on a thread joined to what is left.
    # An abandoned fetch is left to finish: it still warms the cache for the
    # next poll or the first real check.
    def fetch_company_id_within(company, deadline)
      remaining = deadline - monotonic_ms
      return nil if remaining <= 0

      fetch = Thread.new { @datastream_client.get_company(company) }
      fetch.abort_on_exception = false
      resolved = fetch.join(remaining / 1000.0)&.value
      resolved && (resolved[:id] || resolved["id"])
    rescue StandardError => e
      @logger.debug("prewarm: datastream company fetch failed (#{e.message})")
      nil
    end

    def shut_down_credit_leases
      @reservations&.stop
      return if @credit_lease_manager.nil?

      # Refuse new lease work first, so the waits below are waiting on work that
      # is already unwinding rather than work still starting. Both steps run for
      # a shared backend too: the work must not outlive the client, even where
      # there is nothing to release.
      @credit_lease_manager.stop
      # One budget across both waits, not each timeout in turn: a caller closing
      # a client wants a bounded shutdown, not the sum of every wait inside it.
      deadline = monotonic_ms + Credits::Leases::SHUTDOWN_DRAIN_TIMEOUT_MS
      prewarms = @pending_prewarms_mutex.synchronize { @pending_prewarms.dup }
      prewarms.each do |thread|
        remaining = deadline - monotonic_ms
        break if remaining <= 0

        thread.join(remaining / 1000.0)
      end
      if prewarms.any?(&:alive?)
        @logger.warn(
          "Timed out after #{Credits::Leases::SHUTDOWN_DRAIN_TIMEOUT_MS}ms waiting for in-flight prewarms on close"
        )
      end
      @credit_lease_manager.drain([deadline - monotonic_ms, 0].max)
      return if @lease_backend_shared

      # The releases share the shutdown budget too, so a slow API cannot stretch
      # close past what the caller was promised.
      @credit_lease_manager.release_all_local_leases([deadline - monotonic_ms, 0].max)
    end

    def monotonic_ms
      Process.clock_gettime(Process::CLOCK_MONOTONIC) * 1000
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

      # Only forward an explicit frame-size limit; when unset the websocket gem's
      # own default (20MB) applies and no global state is touched.
      ds_opts[:max_frame_size] = options[:max_frame_size] if options[:max_frame_size]

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
