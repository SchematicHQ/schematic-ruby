# frozen_string_literal: true

require "securerandom"
require "time"

module Schematic
  module Credits
    module Leases
      # Everything a server-mode check needs. reservation_ttl_ms is how far out
      # the hold's expires_at is set, and default_value resolves the caller's
      # default for the flag, which the fail-open branch returns because there
      # is no local engine to re-run.
      ServerCheckDeps = Struct.new(:features, :credits, :logger, :reservation_ttl_ms, :default_value, :clock,
                                   keyword_init: true)

      # Mirrors the reason the API returns on a 200 with value false for the
      # same denial, so a caller matching on reason has one string to match
      # either way.
      INSUFFICIENT_CREDITS_REASON = "Insufficient credits"

      # Drive a single check with usage set, in server mode.
      #
      # One check-and-reserve call does everything the client path spreads
      # across a lease acquire, a local reserve, and a rules evaluation: the
      # server evaluates the flag against the company's real balance, applies
      # the preflight cost, and takes the hold in the same round trip. There is
      # no lease, no local store, and no rules engine involved.
      #
      # The failure contract differs from client mode in one place. fail-open
      # there means re-run the engine with the credit balance assumed
      # sufficient, so plan targeting and every non-credit condition still
      # apply. Server mode has no local engine to re-run, since the call that
      # would have answered is the one that failed, so fail-open returns the
      # caller's default value instead. fail-closed denies, same as client mode.
      #
      # No flag_check event is enqueued here: the server logs the flag check for
      # check-and-reserve itself, the same way the REST check path does.
      def self.check_with_server_reservation(deps, key, eval_ctx, options, &fallback)
        ServerCheck.new(deps, key, eval_ctx, options, fallback).run
      end

      class ServerCheck
        def initialize(deps, key, eval_ctx, options, fallback)
          @deps = deps
          @key = key
          @eval_ctx = eval_ctx || {}
          @options = options || {}
          @fallback = fallback
          @logger = deps.logger
          @clock = deps.clock || DEFAULT_CLOCK
          @on_failure = Leases.normalize_symbol(@options[:on_acquire_failure]) || :fail_closed
          # One key for this check, minted before the call rather than per
          # attempt: check-and-reserve takes a hold, so a 502 arriving after the
          # API committed one would otherwise have the retry take a second and
          # park the first until its TTL. Sharing the key across attempts makes
          # the server return the hold it already took.
          @idempotency_key = SecureRandom.uuid
        end

        def run
          usage = @options[:usage]
          # The same guard as the client path: a malformed usage must never
          # reach the wire. NaN slips through every numeric comparison, so the
          # server would size a hold off a value no comparison can reject.
          unless Leases.valid_quantity?(usage)
            @logger.error(
              "Server reservation: invalid usage #{usage.inspect} for flag #{@key}, " \
              "must be a finite non-negative number"
            )
            return failure_result("invalid_usage")
          end

          if usage.zero?
            @logger.debug("Server reservation: usage is 0 for flag #{@key}, nothing to reserve, using plain check")
            return @fallback.call
          end

          data = call_api
          return data if data.is_a?(CheckResult)

          build_result(data)
        end

        private

        def call_api
          response = @deps.features.check_and_reserve_flag(request_options: request_options, **request_body)
          response.data
        rescue StandardError => e
          # A 402 is the server's definitive answer, not a can't-gate: it knows
          # the credits are not there. Deny regardless of the failure mode,
          # since failing open here would hand out credit the balance cannot
          # cover. check-and-reserve itself answers 200 with value false for
          # insufficient credits; this is defensive.
          return payment_required_result(e) if payment_required?(e)

          @logger.error("Server reservation: check-and-reserve for flag #{@key} failed: #{e.message}")
          failure_result("server_reservation_failed")
        end

        def request_body
          # The request body's quantity is an integer, so a fractional usage
          # would truncate and the server would size the hold below the work
          # about to run. Round up, and size the preflight from the same number
          # so the flag is evaluated against the quantity actually held.
          quantity = Leases.wire_quantity(@options[:usage])
          body = {
            key: @key,
            quantity: quantity,
            expires_at: (@clock.call + (@deps.reservation_ttl_ms / 1000.0)).utc.iso8601
          }
          company = @eval_ctx[:company] || @eval_ctx["company"]
          user = @eval_ctx[:user] || @eval_ctx["user"]
          body[:company] = company if company && !company.empty?
          body[:user] = user if user && !user.empty?
          preflight = Leases.build_preflight_options(@options.merge(usage: quantity))
          body[:preflight] = preflight if preflight
          body[:idempotency_key] = @idempotency_key
          body
        end

        # Only the timeout is set here. The call keeps the client's default
        # retry policy, which the idempotency key makes safe.
        def request_options
          return {} if @options[:timeout_ms].nil?

          { timeout_in_seconds: @options[:timeout_ms] / 1000.0 }
        end

        def build_result(data)
          base = CheckResult.new(
            allowed: data.value, value: data.value, reason: data.reason, entitlement: data.entitlement,
            flag_key: data.flag || @key, flag_id: data.flag_id, error: data.error
          )
          held = data.reservation
          # No reservation comes back when the flag denied, the credits were
          # insufficient (a 200 with value false), or the feature is not
          # credit-metered. Nothing was held, so there is nothing to release.
          return base if !data.value || held.nil?

          # The settling track event is named by the event subtype; the caller's
          # explicit one wins, otherwise the server names it on the hold. With
          # neither, the hold could never be settled.
          event_subtype = @options[:event_subtype] || held.event_subtype
          return release_unsettleable(held, base) if event_subtype.nil? || event_subtype.empty?

          CheckResult.new(
            allowed: true, value: true, reason: data.reason, entitlement: data.entitlement,
            flag_key: data.flag || @key, flag_id: data.flag_id,
            reservation: reservation_from(held, event_subtype)
          )
        end

        def reservation_from(held, event_subtype)
          Reservation.new(
            id: held.id,
            # No lease exists in server mode; mirror the id so the field stays
            # populated and a handle round-trips through code that reads it.
            lease_id: held.id,
            mode: :server,
            company_id: held.company_id,
            credit_type_id: held.credit_type_id,
            event_subtype: event_subtype,
            quantity_reserved: held.quantity_reserved,
            credits_reserved: held.credits_reserved,
            consumption_rate: held.consumption_rate,
            expires_at: parse_time(held.expires_at),
            eval_ctx: @eval_ctx
          )
        end

        def release_unsettleable(held, base)
          @logger.error(
            "Server reservation: reservation #{held.id} for flag #{@key} has no event subtype, " \
            "releasing, it could never be settled"
          )
          begin
            @deps.credits.release_credit_reservation(reservation_id: held.id)
          rescue StandardError => e
            @logger.warn(
              "Server reservation: failed to release #{held.id} (#{e.message}); its hold is refunded when it expires"
            )
          end
          return failure_result("missing_event_subtype") if @on_failure == :fail_closed

          # Fail-open means assume the credits are there, and the server has
          # already evaluated the flag and allowed this check. Only the settle
          # is impossible, so keep the server's verdict rather than falling back
          # to the caller's default, which could deny what the server allowed.
          CheckResult.new(
            allowed: base.allowed, value: base.value, reason: base.reason, entitlement: base.entitlement,
            flag_key: base.flag_key, flag_id: base.flag_id, error: "missing_event_subtype"
          )
        end

        # Resolve a can't-gate outcome. fail-closed denies; fail-open returns
        # the caller's default value, since there is no local engine to
        # re-evaluate with an assumed-sufficient balance the way client mode
        # does.
        def failure_result(reason)
          return CheckResult.new(allowed: false, value: false, reason: reason, flag_key: @key, error: reason) if @on_failure == :fail_closed

          value = @deps.default_value.call
          CheckResult.new(allowed: value, value: value, reason: "#{reason}_fail_open", flag_key: @key, error: reason)
        end

        # The generated client has no 402-specific error class, so a payment
        # required arrives as a ClientError carrying the status code.
        def payment_required?(error)
          error.respond_to?(:code) && error.code.to_i == 402
        end

        def payment_required_result(error)
          CheckResult.new(
            allowed: false, value: false, reason: INSUFFICIENT_CREDITS_REASON, flag_key: @key,
            error: api_error_message(error)
          )
        end

        # A response error's message is the raw body, which carries the API's
        # own error string when it is JSON.
        def api_error_message(error)
          parsed = JSON.parse(error.message.to_s)
          parsed.is_a?(Hash) && parsed["error"] ? parsed["error"] : error.message
        rescue StandardError
          error.message
        end

        def parse_time(value)
          return value if value.is_a?(Time)

          Time.iso8601(value.to_s)
        rescue StandardError
          @clock.call
        end
      end
    end
  end
end
