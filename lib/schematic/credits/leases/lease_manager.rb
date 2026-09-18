# frozen_string_literal: true

require "securerandom"

module Schematic
  module Credits
    module Leases
      # One wire call in flight for a slot, plus the figure it asked for, which
      # is what a joiner compares its own shortfall against. Threads that arrive
      # while it runs wait on it instead of issuing a second call.
      class Flight
        attr_reader :requested_additional

        def initialize(requested_additional = nil)
          @requested_additional = requested_additional
          @mutex = Mutex.new
          @condition = ConditionVariable.new
          @done = false
          @value = nil
        end

        def complete(value)
          @mutex.synchronize do
            @value = value
            @done = true
            @condition.broadcast
          end
        end

        # Wait for the flight to land. A timeout_ms of nil waits indefinitely;
        # a shutdown passes its remaining budget so a stalled wire call cannot
        # hold the close open.
        def wait(timeout_ms = nil)
          deadline = timeout_ms ? monotonic_ms + timeout_ms : nil
          @mutex.synchronize do
            until @done
              if deadline
                remaining = deadline - monotonic_ms
                break if remaining <= 0

                @condition.wait(@mutex, remaining / 1000.0)
              else
                @condition.wait(@mutex)
              end
            end
            @value
          end
        end

        def done?
          @mutex.synchronize { @done }
        end

        private

        def monotonic_ms
          Process.clock_gettime(Process::CLOCK_MONOTONIC) * 1000
        end
      end

      # Owns the lifecycle of credit leases for a single client: acquire on
      # first use or after expiry, extend when the local view dips below the low
      # water mark, release on close.
      #
      # Acquire and extend each get their own single-flight map, kept separate
      # so an in-flight extend can never satisfy an acquire. Best-effort: a
      # caller racing ahead of the registration can still duplicate a wire call,
      # which is safe, because the server is idempotent for an active slot,
      # replace keeps the first live lease, and extend reconciles to a total.
      class LeaseManager
        def initialize(wire_client:, lease_store:, logger:, config: {}, clock: DEFAULT_CLOCK)
          @wire = wire_client
          @lease_store = lease_store
          @logger = logger
          @config = config || {}
          @clock = clock
          @flight_mutex = Mutex.new
          @inflight_acquire = {}
          @inflight_extend = {}
          # Lease work nobody joins: the redundant release a lost acquire race
          # issues, and the background extends callers fire and forget. drain
          # waits these out so a close releases what they installed.
          @background = []
          @stopped = false
        end

        def resolve_config(credit_type_id)
          Leases.resolve_config(@config, credit_type_id)
        end

        # Return the slot's lease, acquiring one (or replacing an expired one)
        # if none is live. Never raises: a wire or store failure is logged and
        # reported as nil, so callers route it through their fail-open or
        # fail-closed handling.
        def acquire_if_needed(company_id, credit_type_id, request_options = nil)
          # Past stop the drain has run or is running, so a lease acquired now
          # is one nothing is left to release.
          return log_stopped("acquire", company_id, credit_type_id) if @stopped

          begin
            existing = @lease_store.get(company_id, credit_type_id)
          rescue StandardError => e
            @logger.error("Failed to read lease store for #{company_id}/#{credit_type_id}: #{e.message}")
            return nil
          end
          return existing if existing && !existing.expired?(@clock.call)

          # An expired or absent slot is left for replace to overwrite, which
          # guards on expiry and writes atomically. Dropping it first would be a
          # separate op that can interleave between a sibling's read and its
          # replace, clobbering the lease that sibling just installed.

          # Check again: stop may have landed during the store read.
          return log_stopped("acquire", company_id, credit_type_id) if @stopped

          key = Leases.lease_key(company_id, credit_type_id)
          flight, leader = enlist(@inflight_acquire, key) { Flight.new }
          return log_stopped("acquire", company_id, credit_type_id) if flight.nil?
          return flight.wait unless leader

          begin
            result = acquire(company_id, credit_type_id, request_options)
          ensure
            @flight_mutex.synchronize { @inflight_acquire.delete(key) }
            flight.complete(result)
          end
          result
        end

        # Kick off an extend when one is due, on a background thread a caller can
        # fire and forget. Returns the thread, or nil when nothing is due; the
        # check flow joins it when the extend covers a reserve it just failed.
        #
        # Due means at or below the low-water-mark ratio, or below a named
        # required_credits: one large check should not wait for the next
        # sub-watermark check to top the lease up. Never raises.
        def maybe_extend_in_background(company_id, credit_type_id, required_credits = nil, request_options = nil)
          if @stopped
            # Extending past stop re-holds credits on a lease the close is about
            # to release, or has already released.
            log_stopped("extend", company_id, credit_type_id)
            return nil
          end
          # Decided here rather than inside the thread: most checks sit nowhere
          # near the water mark, and spawning one thread per check to learn that
          # costs far more than the store read that answers it.
          return nil unless extend_due?(company_id, credit_type_id, required_credits)

          # The whole call is tracked, not just the wire call inside it: callers
          # drop the thread on the floor, so between the store read and the
          # extend there would otherwise be a window where a drain sees nothing
          # pending.
          track do
            extend_if_needed(company_id, credit_type_id, required_credits, request_options, allow_follow_up: true)
          end
        end

        # Refuse new lease work. Idempotent, and paired with drain: stopping
        # first is what makes the drain terminate, since nothing can enqueue
        # behind it. Taken under the flight lock that enlist reads it under, so
        # once stop returns no further flight can register and the drain that
        # follows sees every flight there will ever be.
        def stop
          @flight_mutex.synchronize { @stopped = true }
          nil
        end

        # Wait out lease work already on the wire, so a close releases what that
        # work installs instead of orphaning it. Bounded: whatever has not
        # landed by the deadline is abandoned rather than stalling the caller's
        # shutdown, and the credits it holds fall back to server-side expiry.
        def drain(timeout_ms = SHUTDOWN_DRAIN_TIMEOUT_MS)
          deadline = monotonic_ms + timeout_ms
          loop do
            pending_threads, pending_flights = pending_work
            return if pending_threads.empty? && pending_flights.empty?

            remaining = deadline - monotonic_ms
            if remaining <= 0
              @logger.warn(
                "Timed out after #{timeout_ms}ms draining in-flight credit lease work; " \
                "any credits it holds will be released by server-side expiry"
              )
              return
            end
            # Recomputed per thread, not once for the round: a shared budget
            # spent thread by thread would let N stalled threads wait N times
            # the timeout a caller asked close to take.
            pending_threads.each do |thread|
              left = deadline - monotonic_ms
              break if left <= 0

              thread.join(left / 1000.0)
            end
            pending_flights.each { |flight| flight.wait(deadline - monotonic_ms) }
            # Settling one round can enqueue another (an acquire that loses its
            # race fires a release), so keep going until nothing is left.
          end
        end

        # Release every live lease held in the store, returning its unspent
        # remainder now rather than at expiry. ONLY safe per-process: a shared
        # store's siblings are still drawing on those leases, which the list
        # capability check excludes.
        #
        # timeout_ms bounds the whole pass, because each release is a
        # synchronous round trip and a slow API would otherwise stretch close by
        # one timeout per slot. What is left expires server-side, the same
        # outcome a failed release already has.
        def release_all_local_leases(timeout_ms = nil)
          return nil unless @lease_store.respond_to?(:list)

          entries = @lease_store.list
          return nil if entries.nil? || entries.empty?

          deadline = timeout_ms.nil? ? nil : monotonic_ms + timeout_ms
          entries.each_with_index do |entry, index|
            # Skip expired leases: the server already swept and refunded them.
            next if entry.expired?(@clock.call)

            if deadline && monotonic_ms >= deadline
              left = entries[index..].count { |remaining| !remaining.expired?(@clock.call) }
              @logger.warn(
                "Timed out after #{timeout_ms.round}ms releasing credit leases on close; " \
                "#{left} left to server-side expiry"
              )
              break
            end

            begin
              @wire.release(lease_id: entry.lease_id)
              @lease_store.drop(entry.company_id, entry.credit_type_id)
              @logger.debug("Released credit lease #{entry.lease_id} on close")
            rescue StandardError => e
              @logger.warn(
                "Failed to release credit lease #{entry.lease_id} on close " \
                "(it will expire server-side): #{e.message}"
              )
            end
          end
          nil
        end

        private

        def acquire(company_id, credit_type_id, request_options)
          resolved = resolve_config(credit_type_id)
          grant = @wire.acquire(
            company_id: company_id,
            credit_type_id: credit_type_id,
            requested_amount: resolved.lease_size,
            expires_at: @clock.call + (resolved.lease_duration_ms / 1000.0),
            request_options: request_options || {}
          )
          wrote = @lease_store.replace(LeaseEntry.new(
            lease_id: grant.lease_id,
            company_id: grant.company_id,
            credit_type_id: grant.credit_type_id,
            granted_amount: grant.granted_amount,
            expires_at: grant.expires_at
          ))
          # A stop that landed during the wire call means the drain may already
          # have passed, so this lease would be held with nobody left to release
          # it. Hand it back inline rather than waiting out its expiry.
          return release_after_stop(company_id, credit_type_id, grant) if wrote && @stopped
          return @lease_store.get(company_id, credit_type_id) if wrote

          settle_lost_race(company_id, credit_type_id, grant)
        rescue StandardError => e
          @logger.error("Failed to acquire credit lease for #{company_id}/#{credit_type_id}: #{e.message}")
          nil
        end

        def release_after_stop(company_id, credit_type_id, grant)
          @lease_store.drop(company_id, credit_type_id)
          @wire.release(lease_id: grant.lease_id)
          @logger.debug("Released credit lease #{grant.lease_id} acquired during shutdown")
          nil
        rescue StandardError => e
          @logger.warn(
            "Failed to release credit lease #{grant.lease_id} acquired during shutdown " \
            "(it will expire server-side): #{e.message}"
          )
          nil
        end

        # A sibling installed a live lease first, so replace kept theirs. The
        # server is idempotent for an active slot, so ours is normally the SAME
        # lease and releasing it would refund a lease every process is still
        # reserving against. Only a DIFFERENT lease is a redundant hold worth
        # releasing. An empty slot (it expired in the gap) is skipped too: that
        # id may well be what the next acquire is handed back.
        def settle_lost_race(company_id, credit_type_id, grant)
          current = @lease_store.get(company_id, credit_type_id)
          if current && current.lease_id != grant.lease_id
            @logger.debug(
              "Lost acquire race for #{company_id}/#{credit_type_id}; releasing redundant lease #{grant.lease_id}"
            )
            # Fire and forget: a failed release just falls back to lease expiry.
            track do
              @wire.release(lease_id: grant.lease_id)
            rescue StandardError => e
              @logger.warn("Failed to release redundant credit lease #{grant.lease_id}: #{e.message}")
            end
          else
            @logger.debug(
              "Lost acquire race for #{company_id}/#{credit_type_id}; " \
              "server returned the installed lease #{grant.lease_id}, nothing to release"
            )
          end
          current
        end

        # Cheap read-only answer to "would extend_if_needed do anything". It can
        # go stale between here and the thread, which is harmless: the thread
        # re-reads and re-decides under the flight.
        def extend_due?(company_id, credit_type_id, required_credits)
          entry = @lease_store.get(company_id, credit_type_id)
          return false if entry.nil? || entry.expired?(@clock.call)

          resolved = resolve_config(credit_type_id)
          ratio = entry.local_remaining_credits / [entry.granted_amount, 1].max
          ratio <= resolved.low_water_mark ||
            (!required_credits.nil? && entry.local_remaining_credits < required_credits)
        rescue StandardError => e
          # A store blip must not skip an extend that may well be due.
          @logger.warn("Failed to read lease store for #{company_id}/#{credit_type_id}: #{e.message}")
          true
        end

        def extend_if_needed(company_id, credit_type_id, required_credits, request_options, allow_follow_up:)
          begin
            entry = @lease_store.get(company_id, credit_type_id)
          rescue StandardError => e
            @logger.warn("Failed to read lease store for #{company_id}/#{credit_type_id}: #{e.message}")
            return nil
          end
          return nil if entry.nil?
          # Never extend an expired lease: the server treats it as released,
          # with its remainder already refunded to the company balance, so the
          # right move is the fresh acquire the next check performs.
          return nil if entry.expired?(@clock.call)

          resolved = resolve_config(credit_type_id)
          ratio = entry.local_remaining_credits / [entry.granted_amount, 1].max
          below_watermark = ratio <= resolved.low_water_mark
          below_required = !required_credits.nil? && entry.local_remaining_credits < required_credits
          return entry unless below_watermark || below_required

          # Sized to cover the request that triggered it, or a check needing more
          # than the tranche would fail its post-extend retry forever against an
          # ample server balance. Sized here rather than at the wire call so the
          # flight below and the request body provably carry the same number for
          # a joiner to compare against.
          shortfall = required_credits ? required_credits - entry.local_remaining_credits : 0
          additional_amount = [resolved.lease_size, shortfall].max

          key = Leases.lease_key(company_id, credit_type_id)
          flight, leader = enlist(@inflight_extend, key) { Flight.new(additional_amount) }
          return log_stopped("extend", company_id, credit_type_id) if flight.nil?
          # A watermark refresh that finds a flight already running has nothing
          # to wait for: the credits it wants are the ones that call is fetching.
          # Only a caller naming required_credits waits, because it has a reserve
          # to retry.
          return nil if !leader && required_credits.nil?

          unless leader
            joined = flight.wait
            # The flight already asked for at least what we need, which covers
            # every watermark-driven joiner and any check the tranche covers.
            # One wire call serves all of them, which is the point.
            return joined if additional_amount <= flight.requested_additional || !allow_follow_up

            # Our shortfall outran the flight's ask. We waited it out rather
            # than racing a second extend onto the same lease; now top up the
            # difference with exactly one more, re-reading the slot the flight
            # just moved. allow_follow_up: false keeps this from chaining: when
            # the server cannot cover the request, a chain would spin.
            return extend_if_needed(company_id, credit_type_id, required_credits, request_options,
                                    allow_follow_up: false)
          end

          begin
            result = extend(entry, resolved, additional_amount, request_options)
          ensure
            # Identity-guarded rather than an unconditional delete: a joiner
            # whose shortfall outran this flight registers a follow-up for the
            # same key, and this flight must not evict it.
            @flight_mutex.synchronize { @inflight_extend.delete(key) if @inflight_extend[key].equal?(flight) }
            flight.complete(result)
          end
          result
        end

        def extend(entry, resolved, additional_amount, request_options)
          grant = @wire.extend(
            lease_id: entry.lease_id,
            additional_amount: additional_amount,
            expires_at: @clock.call + (resolved.lease_duration_ms / 1000.0),
            # Minted once per extend, outside the wire call, so the transport's
            # retries resend the same key: a retry after a lost 2xx is handed
            # the lease as it stands instead of growing it a second time.
            idempotency_key: SecureRandom.uuid,
            request_options: request_options || {}
          )
          # Reconciled to the server's TOTAL, with the store computing the delta
          # against its own current figure rather than the read above: two
          # sibling processes extending one shared lease would each apply a
          # stale-read delta and mint phantom credits. Pinned to the lease the
          # server extended, so an expiry mid-call drops the delta instead of
          # minting it onto the successor.
          @lease_store.extend(entry.company_id, entry.credit_type_id, grant.granted_amount, grant.expires_at,
                              entry.lease_id)
          @logger.debug(
            "Extended credit lease #{entry.lease_id} to #{grant.granted_amount} " \
            "(was #{entry.granted_amount} at last read)"
          )
          @lease_store.get(entry.company_id, entry.credit_type_id)
        rescue StandardError => e
          @logger.warn("Failed to extend credit lease #{entry.lease_id}: #{e.message}")
          nil
        end

        # Register this caller against the slot's in-flight call, or become the
        # one that makes it. Returns [flight, leader], or [nil, false] once the
        # manager is stopped: the stopped read happens here, under the same lock
        # stop takes, because an unguarded read outside it can be overtaken by a
        # close whose drain then never sees the flight this would have made.
        def enlist(flights, key)
          @flight_mutex.synchronize do
            next [nil, false] if @stopped

            existing = flights[key]
            next [existing, false] if existing

            flight = yield
            flights[key] = flight
            [flight, true]
          end
        end

        # Hold a reference to work nobody joins so drain can wait it out.
        def track(&block)
          thread = Thread.new do
            block.call
          rescue StandardError => e
            @logger.warn("Background credit lease work failed: #{e.message}")
            nil
          end
          thread.abort_on_exception = false
          @flight_mutex.synchronize do
            # Finished work is dropped as new work arrives, so the list tracks
            # what is still pending rather than growing for the process's life.
            @background.select!(&:alive?)
            @background << thread
          end
          thread
        end

        def pending_work
          @flight_mutex.synchronize do
            @background.select!(&:alive?)
            [@background.dup, (@inflight_acquire.values + @inflight_extend.values).reject(&:done?)]
          end
        end

        def log_stopped(action, company_id, credit_type_id)
          @logger.debug("Lease manager is stopped; skipping #{action} for #{company_id}/#{credit_type_id}")
          nil
        end

        def monotonic_ms
          Process.clock_gettime(Process::CLOCK_MONOTONIC) * 1000
        end
      end
    end
  end
end
