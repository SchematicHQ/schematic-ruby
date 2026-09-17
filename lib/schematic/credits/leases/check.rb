# frozen_string_literal: true

require "securerandom"

module Schematic
  module Credits
    module Leases
      # Everything a lease-bearing check needs. enqueue_flag_check_event reports
      # a flag_check event for a check the lease path resolved itself, mirroring
      # the plain check paths so lease-gated checks stay visible to flag-check
      # analytics and company last-seen. Fallback exits do not call it: the
      # plain check they delegate to enqueues its own.
      CheckDeps = Struct.new(:lease_store, :reservations, :manager, :datastream, :logger, :clock,
                             :enqueue_flag_check_event, keyword_init: true)

      # Read a field from an engine payload, which carries camelCase keys inside
      # the entitlement even though the top-level result is normalized.
      def self.field(hash, *names)
        return nil if hash.nil?

        names.each do |name|
          value = hash[name] || hash[name.to_s]
          return value unless value.nil?
        end
        nil
      end

      # The preflight envelope for a client-side rules evaluation. With an
      # event_subtype the quantity goes out as the event_usage pair so the
      # engine matches it to that subtype's condition; without one it goes out
      # as the generic usage knob. Public so the plain check path can thread the
      # same preflight through when the lease path cannot run.
      def self.build_preflight_options(options)
        usage = options[:usage]
        return nil if usage.nil?

        # The preflight quantity is an integer on both seams (the engine
        # envelope and the API's preflight body), and it asks an upper-bound
        # question, so a fractional usage rounds up rather than gating on less
        # usage than the operation is about to record.
        quantity = Leases.wire_quantity(usage)
        # The API documents a zero usage as having no effect, so a check with
        # one is a plain check and not a preflighted one. Sending an empty
        # preflight anyway would cost it the flag cache, on the read and on the
        # write, for a field the server ignores. A zero credit_cost would be
        # different, saying free rather than absent, but this builder never
        # emits one.
        return nil if quantity.zero?

        if options[:event_subtype]
          { event_usage: { event_subtype: options[:event_subtype], quantity: quantity } }
        else
          { usage: quantity }
        end
      end

      # Drive a single lease-gated check.
      #
      # 1. Probe the engine once against the company's real balance, with no
      #    substitution and no preflight, and read the matched entitlement. A
      #    non-credit entitlement means there is nothing to lease, so defer to
      #    the plain check.
      # 2. Acquire (or reuse) a lease for (company, credit id).
      # 3. Reserve usage x consumption_rate from it, atomically.
      # 4. Re-run the engine against a company snapshot whose balance for that
      #    credit is the PRE-reservation local balance, with credit_cost set, so
      #    the engine evaluates the same arithmetic try_reserve just enforced.
      #    The hold only sticks if the engine allows.
      def self.check_with_lease(deps, key, eval_ctx, options, &fallback)
        Check.new(deps, key, eval_ctx, options, fallback).run
      end

      # The check flow, as an object so its steps can pass state without
      # threading a dozen arguments through every helper.
      class Check
        def initialize(deps, key, eval_ctx, options, fallback)
          @deps = deps
          @key = key
          @eval_ctx = eval_ctx || {}
          @options = options || {}
          @fallback = fallback
          @logger = deps.logger
          @clock = deps.clock || DEFAULT_CLOCK
          @on_failure = Leases.normalize_symbol(@options[:on_acquire_failure]) || :fail_closed
        end

        def run
          guard = check_guards
          return guard if guard

          resolved = resolve_entitlement
          return @fallback.call if resolved.nil?

          @credit_id, @consumption_rate, @event_subtype = resolved
          @credit_cost = @options[:usage] * @consumption_rate

          lease = @deps.manager.acquire_if_needed(@company[:id], @credit_id, request_options)
          return failure("lease_acquire_failed") if lease.nil?

          reserve = reserve_credits
          return reserve if reserve.is_a?(CheckResult)

          reservation = register_reservation(reserve)
          persisted = persist(reservation, reserve)
          return persisted if persisted.is_a?(CheckResult)

          gate(reservation, reserve)
        end

        private

        # Guards, in order: a malformed usage never reaches the stores; zero
        # usage has nothing to reserve; and without a datastream, a cached flag,
        # or a resolvable company there is no local evaluation to gate with.
        def check_guards
          usage = @options[:usage]
          # NaN slips through every numeric comparison, so a single NaN debit
          # would poison the (possibly shared) lease balance into approving
          # every later reserve. The stores guard too, but resolve it here
          # through the caller's failure contract rather than letting it surface
          # as an opaque reserve failure.
          unless Leases.valid_quantity?(usage)
            @logger.error(
              "Lease check: invalid usage #{usage.inspect} for flag #{@key}, must be a finite non-negative number"
            )
            return emit(static_failure_result("invalid_usage", nil))
          end

          if usage.zero?
            @logger.debug("Lease check: usage is 0 for flag #{@key}, nothing to reserve, using plain check")
            return @fallback.call
          end

          return @fallback.call if datastream_unavailable?
          return @fallback.call if load_flag.nil?
          return @fallback.call unless entities_resolved?

          nil
        end

        def datastream_unavailable?
          return false if @deps.datastream

          @logger.debug("Credit-lease check requested without datastream, falling back to plain check")
          true
        end

        def load_flag
          @flag = begin
            @deps.datastream.get_flag(@key)
          rescue StandardError => e
            @logger.warn("Lease check: failed to load flag #{@key}: #{e.message}")
            nil
          end
          @logger.debug("Lease check: no cached flag for #{@key}, falling back") if @flag.nil?
          @flag
        end

        # Resolve company and user the way a plain datastream check does. An
        # evaluation with a missing entity is not an option: a nil user would
        # silently skip user-targeted rules and overrides, so a named entity
        # that cannot be resolved falls back to the plain check, which has its
        # own degradation story.
        def entities_resolved?
          company_keys = @eval_ctx[:company] || @eval_ctx["company"]
          if company_keys.nil? || company_keys.empty?
            @logger.debug("Lease check: no company on eval context, falling back")
            return false
          end
          @company = fetch_entity("company") { @deps.datastream.get_company(company_keys) }
          return false if @company.nil?

          user_keys = @eval_ctx[:user] || @eval_ctx["user"]
          return true if user_keys.nil? || user_keys.empty?

          @user = fetch_entity("user") { @deps.datastream.get_user(user_keys) }
          !@user.nil?
        end

        def fetch_entity(kind)
          yield
        rescue StandardError => e
          @logger.debug("Lease check: #{kind} fetch failed (#{e.message}), falling back")
          nil
        end

        # Entitlement-first resolution. One engine probe against the company's
        # real balance, with no preflight and no substitution, surfaces the
        # matched entitlement. Only its shape is read: value_type says whether a
        # credit is metered at all, and a credit entitlement carries credit_id,
        # consumption_rate, and event_subtype directly. This replaces a
        # structural credit-condition scan and lets a non-credit grant skip the
        # lease and reserve round-trip entirely.
        #
        # The probe deliberately omits preflight: applying a credit cost to the
        # lease-depleted server balance could fail the credit condition, drop
        # the engine to a lower-priority rule, and hide the very entitlement
        # being identified. The preflight-aware gate runs later, against the
        # substituted lease balance.
        def resolve_entitlement
          probe = probe_entitlement
          return nil if probe.nil?

          entitlement = probe[:entitlement]
          value_type = Leases.field(entitlement, :valueType, :value_type)
          unless value_type == "credit"
            # A boolean or override grant, a numeric allocation, unlimited, or
            # simply not entitled. The feature resolves without drawing a
            # credit, so skip the lease round-trip and let the plain check,
            # which is preflight-aware, decide.
            @logger.debug(
              "Lease check: flag #{@key} matched a non-credit entitlement " \
              "(value_type=#{value_type || "<none>"}), falling back to plain check, no reservation"
            )
            return nil
          end

          credit_id = Leases.field(entitlement, :creditId, :credit_id)
          consumption_rate = (Leases.field(entitlement, :consumptionRate, :consumption_rate) || 0).to_f
          # The caller's explicit subtype wins; otherwise the entitlement names
          # the metered event. The reservation settles into a track event named
          # by this subtype, so a credit entitlement with neither a resolvable
          # subtype nor a positive rate cannot be billed and is ungateable.
          subtype = @options[:event_subtype] || Leases.field(entitlement, :eventSubtype, :event_subtype)
          if credit_id.nil? || consumption_rate <= 0 || subtype.nil?
            @logger.debug(
              "Lease check: flag #{@key} credit entitlement is incomplete " \
              "(credit_id=#{credit_id || "<none>"}, consumption_rate=#{consumption_rate}, " \
              "subtype=#{subtype || "<none>"}), falling back"
            )
            return nil
          end

          [credit_id, consumption_rate, subtype]
        end

        def probe_entitlement
          evaluate(@company, nil)
        rescue StandardError => e
          # The probe is a resolution step, not the gate, so a failure means the
          # credit could not be resolved. Defer to the plain check rather than
          # hard-denying. No reservation exists yet, so nothing to cancel.
          @logger.warn("Lease check: entitlement probe failed for flag #{@key} (#{e.message}), falling back")
          nil
        end

        # try_reserve is the atomic gate: check and debit in one step, returning
        # the post-debit balance (so the pre-debit figure follows without a
        # second store read) AND the id of the lease it charged. That id, not
        # the acquired one, is what the reservation is pinned to: the debit is
        # not keyed by lease, so the slot's lease may have been replaced since
        # the acquire, and the window spans the extend awaited below.
        def reserve_credits
          reserve = @deps.lease_store.try_reserve(@company[:id], @credit_id, @credit_cost)
          if reserve.nil?
            # The lease has less than credit_cost left locally. Passing
            # credit_cost extends even when the ratio is still above the low
            # water mark, which a single large request needs.
            @deps.manager.maybe_extend_in_background(@company[:id], @credit_id, @credit_cost,
                                                     request_options)&.join
            reserve = @deps.lease_store.try_reserve(@company[:id], @credit_id, @credit_cost)
          end
          return failure("insufficient_lease_balance") if reserve.nil?

          reserve
        rescue StandardError => e
          @logger.error("Lease check: reserve against #{@company[:id]}/#{@credit_id} failed: #{e.message}")
          failure("lease_store_error")
        end

        def register_reservation(reserve)
          resolved = @deps.manager.resolve_config(@credit_id)
          Reservation.new(
            id: SecureRandom.uuid,
            # The lease the debit actually landed on, which may not be the one
            # the acquire handed back. Pinning the acquired id instead would
            # send the settle refund, the sweep refund, and the track event's
            # lease_id to a lease that was never charged.
            lease_id: reserve.lease_id,
            company_id: @company[:id],
            credit_type_id: @credit_id,
            event_subtype: @event_subtype,
            quantity_reserved: @options[:usage],
            credits_reserved: @credit_cost,
            consumption_rate: @consumption_rate,
            expires_at: @clock.call + (resolved.reservation_ttl_ms / 1000.0),
            eval_ctx: @eval_ctx
          )
        end

        # Record the reservation after the debit and before the engine gate.
        # The debit and this record are two steps; persisting the hold means a
        # crash between them leaves a sweepable reservation rather than
        # stranding the debited credits until the whole lease expires. The
        # unprotected window is just the gap between the two, with no I/O in
        # between, and a crash there leaks at most credit_cost until the lease's
        # own expiry reclaims it server-side.
        def persist(reservation, reserve)
          @deps.reservations.add(reservation)
          nil
        rescue StandardError => e
          @logger.error("Lease check: failed to persist reservation #{reservation.id}: #{e.message}")
          undo_debit(reservation, reserve)
          failure("lease_store_error")
        end

        # Undo the local debit so the credits are not stranded until lease
        # expiry. consume claims whatever slice of the add made it to the store
        # and refunds it; if nothing was persisted, refund the debit directly.
        # Both are pinned to the lease the debit landed on. If even the undo
        # fails, accept the bounded leak: the slice is reclaimed when the lease
        # expires server-side, which beats risking a double refund.
        def undo_debit(reservation, reserve)
          undone = @deps.reservations.consume(reservation.id, 0)
          @deps.lease_store.refund(@company[:id], @credit_id, @credit_cost, reserve.lease_id) if undone.nil?
        rescue StandardError => e
          @logger.warn(
            "Lease check: could not undo local debit for #{reservation.id} (#{e.message}); " \
            "the slice is reclaimed at lease expiry"
          )
        end

        # Substitute the lease balance into the company snapshot so the engine
        # gates against the lease's local view rather than the server's
        # authoritative balance, and tell it this action costs credit_cost
        # against this credit id. The engine then checks
        # pre_reservation - credit_cost >= 0, the same arithmetic try_reserve
        # just enforced, plus every non-credit rule. Pre-reservation is the
        # post-debit balance the atomic reserve returned plus the cost it
        # debited: exact as of the debit, with no read race.
        def gate(reservation, reserve)
          pre_reservation = reserve.balance + @credit_cost
          substituted = substitute_credit_balance(@company, @credit_id, pre_reservation)
          begin
            result = evaluate(substituted, { credit_cost: { @credit_id => @credit_cost } })
          rescue StandardError => e
            @logger.error("Lease check: rules engine evaluation failed: #{e.message}")
            # Cancel the hold, then resolve the mode statically: the engine
            # itself just failed, so a fail-open re-evaluation is impossible.
            cancel_reservation(reservation)
            return emit(static_failure_result("wasm_error: #{e.message}", @flag), engine_ids(nil))
          end

          ids = engine_ids(result)
          unless result[:value]
            cancel_reservation(reservation)
            return emit(
              CheckResult.new(
                allowed: false, value: false, reason: result[:reason] || "denied_by_engine",
                entitlement: result[:entitlement], flag_key: result[:flag_key] || @key, flag_id: result[:flag_id]
              ), ids
            )
          end

          # The engine allowed against the substituted lease balance, so the
          # hold stays. No rule-match disambiguation is needed: the probe
          # already established that this company's matched entitlement is the
          # credit one, so an override or boolean grant would have skipped the
          # reserve path. Bumping only the credit balance cannot make a
          # different rule match here.

          # Fire and forget the low-water-mark refresh now that we have debited.
          @deps.manager.maybe_extend_in_background(@company[:id], @credit_id)

          emit(
            CheckResult.new(
              allowed: true, value: true, reservation: reservation,
              reason: result[:reason] || "lease_reserved", entitlement: result[:entitlement],
              flag_key: result[:flag_key] || @key, flag_id: result[:flag_id]
            ), ids
          )
        end

        # Best-effort cancel: claims the record and refunds its full hold.
        def cancel_reservation(reservation)
          @deps.reservations.consume(reservation.id, 0)
        rescue StandardError => e
          @logger.warn(
            "Lease check: failed to cancel reservation #{reservation.id} (#{e.message}); " \
            "its hold is reclaimed by the sweeper or at lease expiry"
          )
        end

        # Every can't-gate outcome (wire failure, store failure, exhausted
        # lease) funnels through here, so the fail-open or fail-closed contract
        # holds even when the backing infrastructure is down.
        #
        # fail-closed denies outright. fail-open means err on the side of
        # assuming the credits are there, NOT skip evaluation: the engine still
        # runs with the credit balance substituted to an effectively unlimited
        # value, so plan targeting, overrides, and every non-credit condition
        # still apply. A company that is not entitled stays denied even with the
        # lease backend down. Only if that evaluation itself fails does the SDK
        # fall back to a blanket allow.
        def failure(reason)
          result =
            if @on_failure == :fail_closed
              static_failure_result(reason, @flag)
            else
              fail_open_result(reason)
            end
          emit(result, { company_id: @company&.dig(:id), user_id: @user&.dig(:id) })
        end

        def fail_open_result(reason)
          substituted = substitute_credit_balance(@company, @credit_id, FAIL_OPEN_BALANCE)
          result = evaluate(substituted, Leases.build_preflight_options(@options))
          CheckResult.new(
            allowed: result[:value], value: result[:value],
            reason: "#{result[:reason] || "evaluated"} (#{reason}_fail_open)",
            entitlement: result[:entitlement], flag_key: result[:flag_key] || @key,
            flag_id: result[:flag_id] || @flag&.dig(:id), error: reason
          )
        rescue StandardError => e
          @logger.warn("Lease check: fail-open evaluation failed (#{e.message}); allowing")
          static_failure_result(reason, @flag)
        end

        # A mode resolved without an engine evaluation: deny for fail-closed,
        # blanket allow for fail-open. Used when the engine itself is the thing
        # that failed, and as the fallback when a fail-open evaluation errors.
        def static_failure_result(reason, flag)
          if @on_failure == :fail_closed
            CheckResult.new(allowed: false, value: false, reason: reason, flag_key: @key,
                            flag_id: flag&.dig(:id), error: reason)
          else
            CheckResult.new(allowed: true, value: true, reason: "#{reason}_fail_open", flag_key: @key,
                            flag_id: flag&.dig(:id), error: reason)
          end
        end

        def evaluate(company, options)
          @deps.datastream.check_flag_with_options(@flag, company, @user, options)
        end

        def substitute_credit_balance(company, credit_id, balance)
          substituted = company.dup
          balances = (company[:credit_balances] || company["credit_balances"] || {}).dup
          # The cache symbolizes keys, so a balance may be filed under either
          # spelling. Replace whichever is there so the engine sees one value.
          balances.delete(credit_id.to_sym)
          balances.delete(credit_id.to_s)
          balances[credit_id] = balance
          substituted[:credit_balances] = balances
          substituted
        end

        def engine_ids(result)
          {
            company_id: (result && result[:company_id]) || @company&.dig(:id),
            user_id: (result && result[:user_id]) || @user&.dig(:id),
            rule_id: result && result[:rule_id]
          }
        end

        # Thread the caller's per-check timeout to the lease wire calls the same
        # way the fallback path threads it to a plain check.
        def request_options
          return {} if @options[:timeout_ms].nil?

          { timeout_in_seconds: @options[:timeout_ms] / 1000.0 }
        end

        def emit(result, ids = {})
          @deps.enqueue_flag_check_event&.call(
            flag_key: result.flag_key,
            value: result.value,
            reason: result.reason,
            error: result.error,
            flag_id: result.flag_id,
            company_id: ids[:company_id],
            user_id: ids[:user_id],
            rule_id: ids[:rule_id],
            req_company: @eval_ctx[:company] || @eval_ctx["company"],
            req_user: @eval_ctx[:user] || @eval_ctx["user"]
          )
          result
        end
      end
    end
  end
end
