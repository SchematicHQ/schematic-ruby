# frozen_string_literal: true

module Schematic
  module Credits
    module Leases
      def self.lease_key(company_id, credit_type_id)
        "#{company_id}:#{credit_type_id}"
      end

      # Per-process lease store, keyed by "<company_id>:<credit_type_id>".
      #
      # Holds the lease id, the server-authoritative granted total, the expiry,
      # and the SDK's local view of local_remaining_credits: the portion of the
      # lease not yet carved out by an open reservation. A per-key mutex keeps
      # reserve, refund, extend, and replace atomic per slot.
      #
      # The store never talks to the API. LeaseManager drives acquire, extend,
      # and release over the wire and uses these methods to mirror remote state.
      #
      # For cross-process deployments use RedisLeaseStore instead: both answer
      # the same calls with the same semantics.
      class LeaseStore
        def initialize(clock: DEFAULT_CLOCK)
          @clock = clock
          @leases = {}
          @locks = {}
          # Guards the two hashes themselves. Always taken inside a key lock,
          # never the other way round, so the pair cannot deadlock.
          @table_mutex = Mutex.new
        end

        # Snapshot of the current entry, or nil when no lease occupies the slot.
        # A copy, so a caller cannot mutate store state by holding the result.
        def get(company_id, credit_type_id)
          key = Leases.lease_key(company_id, credit_type_id)
          with_lock_if_present(key) { read(key)&.dup }
        end

        # Install a fresh lease for the slot, but only if no live lease already
        # occupies it.
        #
        # A live lease is left untouched even when its lease_id differs (a
        # sibling process won the race), so its already-debited
        # local_remaining_credits wins. An expired row carrying the SAME
        # lease_id is not rewritten either: rewriting would reset
        # local_remaining_credits to the full grant and erase debits whose
        # reservations are still open, and the idempotent server hands a racing
        # acquire that same active lease back. Such a row is reconciled like an
        # extend instead: granted to the incoming total, expiry only forward,
        # balance untouched.
        #
        # Returns true when a fresh row was written, false when an existing
        # lease was kept or reconciled.
        def replace(entry)
          key = Leases.lease_key(entry.company_id, entry.credit_type_id)
          with_lock(key) do
            existing = read(key)
            if existing && !existing.expired?(@clock.call)
              false
            elsif existing && existing.lease_id == entry.lease_id
              reconcile(existing, entry.granted_amount, entry.expires_at)
              false
            else
              write(key, LeaseEntry.new(
                lease_id: entry.lease_id,
                company_id: entry.company_id,
                credit_type_id: entry.credit_type_id,
                granted_amount: entry.granted_amount,
                expires_at: entry.expires_at
              ))
              true
            end
          end
        end

        # Reconcile the slot to the server-authoritative granted total after a
        # remote extend, crediting the difference to local_remaining_credits.
        #
        # The delta is computed here against the CURRENT stored total, never by
        # the caller from a pre-wire-call read: two writers extending the same
        # lease concurrently would each apply a delta against the same stale
        # read and mint phantom credits. Reconciling to the absolute total
        # converges in any order, and the expiry only ever moves forward so an
        # out-of-order apply cannot shorten a lease a sibling just extended.
        #
        # When pin_lease_id is given the extend applies only if the slot still
        # holds that lease: the server extended lease A, so its credits must not
        # land on a successor B that replaced A after it expired mid-extend.
        def extend(company_id, credit_type_id, granted_amount, new_expires_at = nil, pin_lease_id = nil)
          key = Leases.lease_key(company_id, credit_type_id)
          with_lock_if_present(key) do
            entry = read(key)
            next if entry.nil?
            next if pin_lease_id && entry.lease_id != pin_lease_id

            reconcile(entry, granted_amount, new_expires_at)
          end
          nil
        end

        # Drop the slot entry, after a remote release. The slot's mutex goes
        # with it, so a long-lived process serving many companies does not
        # accumulate one per (company, credit type) it has ever leased.
        def drop(company_id, credit_type_id)
          key = Leases.lease_key(company_id, credit_type_id)
          with_lock(key) do
            @table_mutex.synchronize do
              @leases.delete(key)
              @locks.delete(key)
            end
          end
          nil
        end

        # Atomically check and debit `credits` from the lease's remaining
        # balance. Returns a ReserveResult carrying the post-debit balance and
        # the lease the debit landed on, or nil when there is no live lease, the
        # balance is short, or `credits` is not a finite non-negative number.
        #
        # The debit is not keyed by lease id: it charges whichever lease holds
        # the slot at that moment, which need not be the one the caller's
        # acquire returned. The caller must therefore pin its reservation to the
        # returned lease_id, since the settle refund, the sweep refund, and the
        # track event's lease_id all have to name the lease that was charged.
        def try_reserve(company_id, credit_type_id, credits)
          # NaN passes every comparison below, and a NaN balance would approve
          # every later reserve, so reject it before it reaches the arithmetic.
          return nil unless Leases.valid_quantity?(credits)

          key = Leases.lease_key(company_id, credit_type_id)
          with_lock_if_present(key) do
            entry = read(key)
            next nil if entry.nil?
            # An expired lease is released server-side and its grant refunded to
            # the company balance, so its local balance is stale.
            next nil if entry.expired?(@clock.call)
            next nil if entry.local_remaining_credits < credits

            entry.local_remaining_credits -= credits
            # The lease id is read under the same lock as the debit: a read
            # afterwards could name a lease that replaced this one in between.
            ReserveResult.new(entry.local_remaining_credits, entry.lease_id)
          end
        end

        # Refund credits to the slot's lease balance, clamped at granted_amount.
        #
        # When pin_lease_id is given the refund applies only if the slot still
        # holds that lease: a hold carved out of expired lease A must never
        # inflate a successor B, because A's unspent remainder was already
        # returned to the company balance server-side when A expired.
        def refund(company_id, credit_type_id, credits, pin_lease_id = nil)
          return nil if credits.nil? || credits <= 0

          key = Leases.lease_key(company_id, credit_type_id)
          with_lock_if_present(key) do
            entry = read(key)
            next if entry.nil?
            next if pin_lease_id && entry.lease_id != pin_lease_id

            entry.local_remaining_credits = [entry.local_remaining_credits + credits, entry.granted_amount].min
          end
          nil
        end

        # Snapshot of every entry. Only the per-process store implements this:
        # close releases the leases this process exclusively holds, and a shared
        # backend must never enumerate, since sibling processes may still be
        # drawing on those leases.
        def list
          keys = @table_mutex.synchronize { @leases.keys }
          keys.filter_map { |key| with_lock(key) { read(key)&.dup } }
        end

        private

        # Granted to the incoming total, expiry only forward, balance untouched
        # except for the credited difference. Shared by replace's same-lease
        # path and extend, which reconcile identically.
        def reconcile(entry, granted_amount, new_expires_at)
          add = granted_amount.to_f - entry.granted_amount
          if add.positive?
            entry.granted_amount = granted_amount.to_f
            entry.local_remaining_credits += add
          end
          return unless new_expires_at && new_expires_at.to_f > entry.expires_at.to_f

          entry.expires_at = new_expires_at
        end

        def read(key)
          @table_mutex.synchronize { @leases[key] }
        end

        def write(key, entry)
          @table_mutex.synchronize { @leases[key] = entry }
        end

        # A read of a slot nothing has leased must not leave a mutex behind, or
        # pruning would only half work: a process checking flags for companies
        # that never lease would still collect one per slot it asked about. With
        # no lock registered and no lease stored there is nothing to serialize
        # against, so answer without taking one. A writer landing in that window
        # is the same race as reading a moment earlier.
        def with_lock_if_present(key, &)
          present = @table_mutex.synchronize { @locks.key?(key) || @leases.key?(key) }
          return nil unless present

          with_lock(key, &)
        end

        # Serialize on the slot's mutex, re-checking after the acquire that it
        # is still the registered one.
        #
        # Pruning is what makes the re-check necessary. A drop deletes the mutex
        # while holding it, so a thread that was already blocked on it wakes
        # owning an object the table no longer knows about, while a thread
        # arriving afterwards takes a fresh mutex for the same slot. Without the
        # check those two would run side by side on one slot. The waiter sees
        # its mutex is no longer the registered one and retries against the
        # current one instead. Every retry follows a drop, which happens once
        # per lease, so the loop cannot spin.
        def with_lock(key, &block)
          loop do
            lock = @table_mutex.synchronize { @locks[key] ||= Mutex.new }
            stale = false
            result = lock.synchronize do
              stale = @table_mutex.synchronize { !@locks[key].equal?(lock) }
              block.call unless stale
            end
            return result unless stale
          end
        end
      end
    end
  end
end
