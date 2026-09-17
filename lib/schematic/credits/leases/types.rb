# frozen_string_literal: true

require "time"

module Schematic
  module Credits
    # Client-side credit leases, reservations, and preflight checks.
    #
    # A credit-metered feature is gated without a wire call per check: the SDK
    # leases a tranche of credits per (company, credit type), carves a
    # reservation out of it at check time, and settles the reservation against
    # the actual usage when the work finishes. See conformance/SPEC.md at the
    # repo root for the full model; the vectors there pin the semantics every
    # Schematic SDK shares.
    module Leases
      # Durations are milliseconds throughout, matching the names and units the
      # other SDKs use so one set of numbers configures a mixed fleet.

      DEFAULT_LEASE_DURATION_MS = 5 * 60 * 1000
      DEFAULT_RESERVATION_TTL_MS = 60 * 1000
      # The API rejects a hold whose expires_at is more than an hour out, so a
      # larger reservation TTL would fail every server-mode check. The SDK
      # clamps to this instead.
      MAX_RESERVATION_TTL_MS = 60 * 60 * 1000
      # The API measures that hour against its own clock while the SDK computes
      # expires_at against the caller's, so a client running ahead would be
      # rejected at exactly the cap. Hold this much back from it.
      RESERVATION_TTL_SKEW_ALLOWANCE_MS = 60 * 1000
      DEFAULT_LEASE_SIZE = 10_000
      DEFAULT_LOW_WATER_MARK = 0.25
      DEFAULT_SWEEP_INTERVAL_MS = 1000
      # How long prewarm is willing to wait for a freshly identified company to
      # surface in the datastream cache before giving up. Long enough to cover
      # the buffer-flush, server-ingest, datastream-push round trip for a new
      # company; short enough that a misconfigured caller does not hang.
      DEFAULT_PREWARM_RESOLVE_TIMEOUT_MS = 5000
      DEFAULT_PREWARM_POLL_INTERVAL_MS = 100
      # How long close waits for in-flight lease work to land before giving up
      # on it. Bounded on purpose: a shutdown that hangs is worse than a hold
      # the server expires at DEFAULT_LEASE_DURATION_MS.
      SHUTDOWN_DRAIN_TIMEOUT_MS = 5000

      # Balance substituted for a fail-open evaluation: large enough that the
      # credit gate always passes, and the same figure the other SDKs use so a
      # shared vector can name it.
      FAIL_OPEN_BALANCE = (2**53) - 1

      # Where a credit hold lives for a check that passes usage.
      # :client - local leases over DataStream.
      # :server - one check-and-reserve API call per check.
      # :auto   - client when DataStream is enabled, server otherwise.
      MODES = %i[client server auto].freeze

      # What to do when a lease cannot be acquired or reserved against.
      # :fail_open   - re-run the engine with the credit balance assumed
      #                sufficient, so non-credit rules still apply.
      # :fail_closed - deny, because the gate cannot gate.
      FAILURE_MODES = %i[fail_open fail_closed].freeze

      # Reads the current time. Every store and the lease manager take one so
      # tests and the conformance runner can drive a virtual clock instead of
      # wall time.
      DEFAULT_CLOCK = -> { Time.now }

      # Convert a caller-supplied mode to a symbol, accepting the hyphenated
      # spellings the other SDKs use ("fail-open") so one config shape travels.
      def self.normalize_symbol(value)
        return nil if value.nil?

        value.to_s.tr("-", "_").downcase.to_sym
      end

      # Whether a caller-supplied quantity can size a credit hold. NaN is the
      # dangerous case: it slips through every numeric comparison, and a NaN
      # balance would approve every later reserve on a possibly shared lease.
      def self.valid_quantity?(value)
        value.is_a?(Numeric) && !value.to_f.nan? && value.to_f.finite? && value >= 0
      end

      # The local view of the one lease a (company, credit type) slot holds.
      class LeaseEntry
        attr_accessor :lease_id, :company_id, :credit_type_id, :granted_amount,
                      :local_remaining_credits, :expires_at

        def initialize(lease_id:, company_id:, credit_type_id:, granted_amount:, expires_at:,
                       local_remaining_credits: nil)
          @lease_id = lease_id
          @company_id = company_id
          @credit_type_id = credit_type_id
          @granted_amount = granted_amount.to_f
          @local_remaining_credits = (local_remaining_credits || granted_amount).to_f
          @expires_at = expires_at
        end

        def dup
          LeaseEntry.new(
            lease_id: @lease_id,
            company_id: @company_id,
            credit_type_id: @credit_type_id,
            granted_amount: @granted_amount,
            local_remaining_credits: @local_remaining_credits,
            expires_at: @expires_at
          )
        end

        def expired?(now)
          @expires_at.to_f <= now.to_f
        end
      end

      # The post-debit balance a successful try_reserve returns, plus the id of
      # the lease the credits actually came out of. The debit is not keyed by
      # lease id, so the caller pins its reservation to this id and never to the
      # one its acquire handed back.
      ReserveResult = Struct.new(:balance, :lease_id)

      # One credit hold carved out of a lease by a check. Returned to the caller
      # from check and handed back to track_with_reservation.
      class Reservation
        attr_reader :id, :lease_id, :mode, :company_id, :credit_type_id, :event_subtype,
                    :quantity_reserved, :credits_reserved, :consumption_rate, :expires_at, :eval_ctx

        def initialize(id:, lease_id:, company_id:, credit_type_id:, event_subtype:,
                       quantity_reserved:, credits_reserved:, consumption_rate:, expires_at:,
                       eval_ctx: {}, mode: nil)
          @id = id
          @lease_id = lease_id
          # :server means the API holds the credits and the settling track event
          # routes by reservation_id; nil (or :client) means the hold is a local
          # carve-out of a lease.
          @mode = mode
          @company_id = company_id
          @credit_type_id = credit_type_id
          @event_subtype = event_subtype
          @quantity_reserved = quantity_reserved.to_f
          @credits_reserved = credits_reserved.to_f
          @consumption_rate = consumption_rate.to_f
          @expires_at = expires_at
          @eval_ctx = eval_ctx || {}
        end

        def server_mode?
          @mode == :server
        end

        def to_h
          {
            id: @id,
            lease_id: @lease_id,
            mode: @mode,
            company_id: @company_id,
            credit_type_id: @credit_type_id,
            event_subtype: @event_subtype,
            quantity_reserved: @quantity_reserved,
            credits_reserved: @credits_reserved,
            consumption_rate: @consumption_rate,
            expires_at: @expires_at,
            eval_ctx: @eval_ctx
          }
        end
      end

      # Cast a usage onto the integer the wire carries. A hold can be sized from
      # a fractional usage, but every quantity field on the API (the
      # check-and-reserve ask, the preflight envelope, a track event) is an
      # integer, and the generated models truncate a float onto it. A preflight
      # asks an upper-bound question and a settle must not bill a partial unit
      # as none, so a fraction rounds up in both directions.
      def self.wire_quantity(value)
        return value unless value.is_a?(Numeric)
        return value unless value.finite?

        value.ceil
      end

      # One shape for the matched entitlement whichever mode produced it.
      #
      # The WASM engine hands back a camelCase hash and the API hands back a
      # generated model, so without this a caller reading result.entitlement
      # would need one accessor for client mode and another for server mode.
      # Both become a snake_case, symbol-keyed Hash matching the field names on
      # Schematic::Types::FeatureEntitlement, and metric_reset_at is parsed to a
      # Time so a caller can compare it without knowing which mode it came from.
      def self.normalize_entitlement(raw)
        return nil if raw.nil?

        hash = raw.is_a?(Hash) ? raw : entitlement_to_h(raw)
        return nil if hash.nil?

        normalized = deep_snake_case(hash)
        reset_at = normalized[:metric_reset_at]
        normalized[:metric_reset_at] = parse_reset_at(reset_at) unless reset_at.nil?
        normalized
      end

      def self.entitlement_to_h(raw)
        return raw.to_h if raw.respond_to?(:to_h)

        nil
      end
      private_class_method :entitlement_to_h

      def self.parse_reset_at(value)
        return value if value.is_a?(Time)

        Time.iso8601(value.to_s)
      rescue StandardError
        value
      end
      private_class_method :parse_reset_at

      def self.deep_snake_case(value)
        case value
        when Hash
          value.each_with_object({}) do |(key, inner), out|
            out[key.to_s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym] = deep_snake_case(inner)
          end
        when Array
          value.map { |inner| deep_snake_case(inner) }
        else
          value
        end
      end
      private_class_method :deep_snake_case

      # What a lease-aware check decided. `allowed` is what the caller gates on;
      # `reservation` is present only when a hold was taken.
      class CheckResult
        attr_reader :allowed, :value, :reservation, :reason, :entitlement, :flag_key, :flag_id, :error

        def initialize(allowed:, value:, reason:, flag_key:, reservation: nil, entitlement: nil,
                       flag_id: nil, error: nil)
          @allowed = allowed
          @value = value
          @reservation = reservation
          @reason = reason
          @entitlement = Leases.normalize_entitlement(entitlement)
          @flag_key = flag_key
          @flag_id = flag_id
          @error = error
        end

        def allowed?
          @allowed
        end

        def to_h
          {
            allowed: @allowed,
            value: @value,
            reservation: @reservation&.to_h,
            reason: @reason,
            entitlement: @entitlement,
            flag_key: @flag_key,
            flag_id: @flag_id,
            error: @error
          }.compact
        end
      end

      # The four resolvable knobs for one credit type, after overrides and
      # defaults.
      ResolvedLeaseConfig = Struct.new(:lease_duration_ms, :reservation_ttl_ms, :lease_size, :low_water_mark,
                                       keyword_init: true)

      # Resolve the knobs for one credit type: the credit type's override wins,
      # then the client-wide config, then the default.
      def self.resolve_config(config, credit_type_id)
        config ||= {}
        overrides = config[:overrides] || {}
        override = overrides[credit_type_id] || overrides[credit_type_id.to_s] || {}
        ResolvedLeaseConfig.new(
          lease_duration_ms: override[:default_lease_duration] || config[:default_lease_duration] ||
            DEFAULT_LEASE_DURATION_MS,
          reservation_ttl_ms: override[:default_reservation_ttl] || config[:default_reservation_ttl] ||
            DEFAULT_RESERVATION_TTL_MS,
          lease_size: override[:default_lease_size] || config[:default_lease_size] || DEFAULT_LEASE_SIZE,
          low_water_mark: override[:low_water_mark] || config[:low_water_mark] || DEFAULT_LOW_WATER_MARK
        )
      end
    end
  end
end
