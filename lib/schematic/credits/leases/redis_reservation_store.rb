# frozen_string_literal: true

require "json"

module Schematic
  module Credits
    module Leases
      # Redis-backed reservation table. Each reservation is a hash, indexed by
      # expires_at in a sorted set so the sweeper can pop expired entries in
      # O(log n), and by (company, credit) so a balance display can sum a
      # tenant's open holds.
      #
      # Every mutation is a single-key operation or single-key Lua, so the store
      # is correct on standalone and clustered Redis alike: the unspent-slice
      # refund is delegated to the lease store rather than reaching across to
      # the lease hash inside a multi-key script.
      class RedisReservationStore
        DEFAULT_KEY_PREFIX = "schematic:"
        RES_KEY_NAMESPACE = "credit-reservation:"
        # Sorted set scoring open reservations by expires_at. Members encode the
        # full (company, credit, id) tuple so the sweeper can clean the
        # per-tenant hash even after the reservation hash has TTL-evicted, at
        # which point the claim returns nil and cannot report company or credit;
        # otherwise the orphaned field would permanently inflate reserved_credits.
        RES_INDEX_KEY = "credit-reservations:byExpiry"
        # Per-(company, credit) index of open reservations, one hash of
        # reservationId to creditsReserved. reserved_credits then reads a whole
        # tenant's holds with ONE HGETALL (single key, Cluster-safe) and sums the
        # values. The hash also IS the source of truth for the sum: a field
        # exists iff its reservation is open and unrefunded.
        RES_BYCREDIT_NAMESPACE = "credit-reservations:byCredit:"
        # Buffer past expires_at before Redis auto-evicts the row, so the
        # sweeper has a window to refund.
        RES_TTL_GRACE_MS = 30_000
        # The delimiter is absent from Schematic ids and from the UUID
        # reservation id.
        MEMBER_DELIMITER = "|"
        # Page size for the sweeper's ZRANGEBYSCORE. Without a limit, a backlog
        # of expired holds would come back as one giant reply on every tick.
        SWEEP_BATCH_SIZE = 256
        # Upper bound on pages per tick. Keeps one sweep's work bounded and
        # guards against an endless loop if a zrem persistently fails. Anything
        # left over is picked up next tick.
        MAX_SWEEP_BATCHES = 16

        # Atomic claim: read the reservation hash and delete it in one step,
        # returning its fields, or nil if it was already gone. One key, so it is
        # Cluster-safe. The atomic read-then-delete is what makes consume
        # exactly-once: of two racing callers only one gets the fields back and
        # proceeds to refund. The refund is a separate single-key op; a crash in
        # the gap leaves the unspent slice held on the lease until the lease
        # itself expires, never double-refunded.
        CLAIM_SCRIPT = Script.new(<<~LUA)

          local raw = redis.call('HGETALL', KEYS[1])
          if #raw == 0 then return nil end
          redis.call('DEL', KEYS[1])
          return raw
        LUA

        def initialize(client:, lease_store:, sweep_interval_ms: DEFAULT_SWEEP_INTERVAL_MS, key_prefix: nil,
                       clock: DEFAULT_CLOCK, logger: nil)
          @client = client
          @lease_store = lease_store
          @sweep_interval_ms = sweep_interval_ms
          @key_prefix = key_prefix || DEFAULT_KEY_PREFIX
          @clock = clock
          @logger = logger
          @mutex = Mutex.new
          @sweep_thread = nil
          @stopped = false
        end

        def add(reservation)
          expires_ms = millis(reservation.expires_at)
          key = hash_key(reservation.id)
          fields = [
            "id", reservation.id,
            "leaseId", reservation.lease_id,
            "companyId", reservation.company_id,
            "creditTypeId", reservation.credit_type_id,
            "eventSubtype", reservation.event_subtype.to_s,
            "quantityReserved", reservation.quantity_reserved.to_s,
            "creditsReserved", reservation.credits_reserved.to_s,
            "consumptionRate", reservation.consumption_rate.to_s,
            "expiresAt", expires_ms.to_s,
            "evalCtx", JSON.generate(reservation.eval_ctx)
          ]
          ttl_at = expires_ms + RES_TTL_GRACE_MS
          # The hash and its expiry go out as one MULTI/EXEC. Written
          # separately, a crash in the gap leaves a reservation row with no TTL:
          # once the sweeper drops its index entry, nothing points at the row
          # and nothing reaps it, so it sits in Redis for good. Same commands,
          # same key, same fields, so what other SDKs read is unchanged, and
          # both commands touch the one key, so this is Cluster-safe.
          if @client.respond_to?(:multi)
            @client.multi do |tx|
              tx.hset(key, *fields)
              tx.pexpireat(key, ttl_at)
            end
          else
            @client.hset(key, *fields)
            @client.pexpireat(key, ttl_at)
          end
          # The two indexes (expiry zset for the sweeper, per-tenant hash for
          # reserved_credits) only depend on the hash existing, so they stay
          # outside the transaction: their keys hash to other slots. A partial
          # failure here at worst leaves an un-indexed reservation that the TTL
          # reaps, never a double spend.
          @client.zadd(index_key, expires_ms, encode_member(reservation.company_id, reservation.credit_type_id,
                                                            reservation.id))
          @client.hset(by_credit_key(reservation.company_id, reservation.credit_type_id), reservation.id,
                       reservation.credits_reserved.to_s)
          nil
        end

        def get(id)
          raw = @client.hgetall(hash_key(id))
          return nil if raw.nil? || raw["id"].nil?

          decode_reservation(raw)
        end

        # Sum a tenant's open holds with a single HGETALL on the per-tenant
        # index hash: one round trip, one key, no per-reservation fan-out. A
        # field is present iff its reservation is open and unrefunded, so the
        # sum is exact.
        def reserved_credits(company_id, credit_type_id)
          by_credit = begin
            @client.hgetall(by_credit_key(company_id, credit_type_id))
          rescue StandardError
            {}
          end
          (by_credit || {}).values.sum(&:to_f)
        end

        def consume(id, credits_consumed)
          # Atomically claim the reservation hash. Only one caller wins; a
          # duplicate or racing consume gets nil.
          claimed = CLAIM_SCRIPT.call(@client, keys: [hash_key(id)], argv: [])
          raw = decode_raw_array(claimed)
          return nil if raw.nil? || raw["id"].nil?

          company_id = raw["companyId"]
          credit_type_id = raw["creditTypeId"]
          reserved = raw["creditsReserved"].to_f

          # Index cleanup, single-key ops. The credits leave the per-tenant hash
          # BEFORE the refund below so the lease (local remaining plus this
          # hash) never transiently double-counts the slice, and before the
          # expiry index because that index is the only way the sweeper reaches
          # a surviving field: dropping the index first and then failing on the
          # field would inflate reserved_credits for that tenant forever.
          swallow { @client.hdel(by_credit_key(company_id, credit_type_id), id) }
          swallow { @client.zrem(index_key, encode_member(company_id, credit_type_id, id)) }

          consumed = credits_consumed.clamp(0, reserved)
          refund = reserved - consumed
          if refund.positive?
            # Delegated to the lease store, which owns the lease hash, so the
            # cross-key write stays out of a single Lua script. Pinned to the
            # reservation's leaseId so a hold carved out of an expired lease
            # cannot inflate a successor lease's balance.
            @lease_store.refund(company_id, credit_type_id, refund, raw["leaseId"])
          end
          consumed
        end

        def start_sweep
          @mutex.synchronize do
            # alive?, not presence: a process that forks after start (Puma or
            # Unicorn with preload) hands the child a thread object whose thread
            # did not survive the fork, and the child would never sweep.
            return if @sweep_thread&.alive? || @stopped

            interval = @sweep_interval_ms.to_f / 1000.0
            @sweep_thread = Thread.new do
              loop do
                sleep(interval)
                break if @stopped

                begin
                  sweep_expired
                rescue StandardError => e
                  @logger&.debug("Reservation sweep failed: #{e.message}")
                end
              end
            end
            @sweep_thread.abort_on_exception = false
          end
        end

        def sweep_expired(now = nil)
          cutoff = millis(now || @clock.call)
          swept = 0
          # Page through expired members rather than fetching them all at once.
          # Each processed member is removed below, so re-reading at offset 0
          # advances through the backlog.
          MAX_SWEEP_BATCHES.times do
            expired = @client.zrangebyscore(index_key, 0, cutoff, limit: [0, SWEEP_BATCH_SIZE]) || []
            break if expired.empty?

            expired.each { |member| swept += 1 if member_refunded?(member) }
            break if expired.size < SWEEP_BATCH_SIZE
          end
          swept
        end

        def stop
          thread = @mutex.synchronize do
            @stopped = true
            thread = @sweep_thread
            @sweep_thread = nil
            thread
          end
          return nil if thread.nil?

          # A sweep past its claim has deleted the reservation but not yet
          # refunded the lease, and killing it there strands the unspent slice
          # until the lease expires. Give it a bounded moment to land that
          # refund, then kill: the loop checks @stopped as soon as its sleep
          # ends, so a parked sweeper costs at most this wait.
          thread.kill unless thread.join(SWEEP_STOP_JOIN_MS / 1000.0)
          nil
        end

        def size
          @client.zcard(index_key)
        rescue StandardError
          0
        end

        private

        def member_refunded?(member)
          decoded = decode_member(member)
          if decoded.nil?
            # Nothing but add writes these, so this is belt and braces. Drop it
            # so an unparseable member cannot wedge the sweeper.
            swallow { @client.zrem(index_key, member) }
            return false
          end
          company_id, credit_type_id, id = decoded
          refunded = consume(id, 0)
          # Always drop the member just read. On the success path consume
          # already removed it, so this is an idempotent no-op; it also covers
          # the hash-evicted path below.
          swallow { @client.zrem(index_key, member) }
          return true unless refunded.nil?

          # The claim found no reservation hash. Either a racing track already
          # consumed it and reconciled the byCredit field, or the hash
          # TTL-evicted before the sweeper reached it, orphaning that field.
          # Reconcile it so reserved_credits cannot keep summing an evicted
          # hold. The unspent slice is NOT refunded here: without the hash the
          # claim cannot arbitrate exactly-once across racing sweepers, so the
          # slice is reclaimed when the lease itself expires server-side.
          swallow { @client.hdel(by_credit_key(company_id, credit_type_id), id) }
          false
        end

        def hash_key(id)
          "#{@key_prefix}#{RES_KEY_NAMESPACE}#{id}"
        end

        def index_key
          "#{@key_prefix}#{RES_INDEX_KEY}"
        end

        def by_credit_key(company_id, credit_type_id)
          "#{@key_prefix}#{RES_BYCREDIT_NAMESPACE}#{company_id}:#{credit_type_id}"
        end

        def encode_member(company_id, credit_type_id, id)
          [company_id, credit_type_id, id].join(MEMBER_DELIMITER)
        end

        def decode_member(member)
          parts = member.to_s.split(MEMBER_DELIMITER)
          return nil unless parts.size == 3

          parts
        end

        def millis(time)
          (time.to_f * 1000).round
        end

        def swallow
          yield
        rescue StandardError
          nil
        end

        # Decode a flat [field, value, field, value, ...] HGETALL array, which
        # is what the claim script returns.
        def decode_raw_array(raw)
          return nil unless raw.is_a?(Array) && !raw.empty?

          out = {}
          raw.each_slice(2) { |field, value| out[field.to_s] = value.to_s if value }
          out
        end

        def decode_reservation(raw)
          Reservation.new(
            id: raw["id"],
            lease_id: raw["leaseId"],
            company_id: raw["companyId"],
            credit_type_id: raw["creditTypeId"],
            event_subtype: raw["eventSubtype"],
            quantity_reserved: raw["quantityReserved"].to_f,
            credits_reserved: raw["creditsReserved"].to_f,
            consumption_rate: raw["consumptionRate"].to_f,
            expires_at: Time.at(raw["expiresAt"].to_f / 1000.0),
            eval_ctx: raw["evalCtx"] ? JSON.parse(raw["evalCtx"], symbolize_names: true) : {}
          )
        end
      end
    end
  end
end
