# frozen_string_literal: true

require "digest"

module Schematic
  module Credits
    module Leases
      # Minimal interface describing the Redis client methods the lease and
      # reservation stores use. Compatible with the "redis" gem's client, which
      # is deliberately not a dependency: the caller injects a client it already
      # has, the same way RedisCacheProvider takes one.
      module RedisLeaseClientInterface
        def evalsha(sha, keys:, argv:)
          raise NotImplementedError
        end

        def eval(script, keys:, argv:)
          raise NotImplementedError
        end

        def hgetall(key)
          raise NotImplementedError
        end

        # Called as hset(key, field1, value1, field2, value2, ...).
        def hset(key, *pairs)
          raise NotImplementedError
        end

        def hdel(key, field)
          raise NotImplementedError
        end

        def del(*keys)
          raise NotImplementedError
        end

        def pexpireat(key, millis)
          raise NotImplementedError
        end

        def zadd(key, score, member)
          raise NotImplementedError
        end

        def zrem(key, member)
          raise NotImplementedError
        end

        def zrangebyscore(key, min, max, limit: nil)
          raise NotImplementedError
        end

        def zcard(key)
          raise NotImplementedError
        end
      end

      # A Lua script addressed by its SHA. EVALSHA first so the script body is
      # not resent on every call; a Redis that has never seen it (a restart, or
      # a node this process has not talked to) answers NOSCRIPT and the full
      # body goes out once to load it.
      class Script
        attr_reader :source, :sha

        def initialize(source)
          @source = source
          @sha = Digest::SHA1.hexdigest(source)
        end

        def call(client, keys:, argv:)
          client.evalsha(@sha, keys: keys, argv: argv)
        rescue StandardError => e
          raise unless e.message.to_s.include?("NOSCRIPT")

          client.eval(@source, keys: keys, argv: argv)
        end
      end

      # Redis-backed lease store. One hash per (company_id, credit_type_id)
      # slot, mutated by single-key Lua scripts so the store stays correct on
      # standalone and clustered Redis alike.
      #
      # The scripts below are byte-identical to the ones the Node, Go, and
      # Python SDKs ship, and the key layout matches, so a mixed-language fleet
      # shares one lease per slot. Do not re-derive them.
      class RedisLeaseStore
        DEFAULT_KEY_PREFIX = "schematic:"
        LEASE_KEY_NAMESPACE = "credit-lease:"
        # How long after the declared expiry the Redis row is kept before
        # auto-eviction. Gives the sweeper a window to refund expired
        # reservations before the underlying lease state disappears.
        LEASE_TTL_GRACE_MS = 60_000

        # Every script below touches exactly ONE key (the lease hash), which
        # keeps them safe under Redis Cluster, where a multi-key script spanning
        # slots raises CROSSSLOT. Only the lease hash needs atomic mutation;
        # cross-key bookkeeping uses ordinary single-key commands.
        #
        # Expiry is decided against the Redis server's clock (redis.call('TIME')),
        # not the calling process's: with many processes sharing one lease, local
        # clock skew would let them disagree on whether the lease is live.

        # Atomic replace. Writes the lease hash only when the slot is empty or
        # the existing lease has expired. Returns 1 on write, 0 when a LIVE
        # lease already occupies the slot, even one with a different leaseId
        # installed by a sibling that raced this acquire. An expired row with
        # the SAME leaseId is reconciled like an extend instead of rewritten,
        # since rewriting would reset the balance and erase debits whose
        # reservations are still open.
        REPLACE_SCRIPT = Script.new(<<~LUA)

          redis.replicate_commands()
          local t = redis.call('TIME')
          local now = (tonumber(t[1]) * 1000) + math.floor(tonumber(t[2]) / 1000)

          local existing_id = redis.call('HGET', KEYS[1], 'leaseId')
          local existing_expiry = tonumber(redis.call('HGET', KEYS[1], 'expiresAt') or '0')
          local new_id = ARGV[1]
          local new_granted = ARGV[2]
          local new_expiry = tonumber(ARGV[3])
          local grace = tonumber(ARGV[4])

          if existing_id and existing_expiry > now then
              return 0
          end

          if existing_id == new_id then
              local granted = tonumber(redis.call('HGET', KEYS[1], 'grantedAmount') or '0')
              local add = tonumber(new_granted) - granted
              if add > 0 then
                  local remaining = tonumber(redis.call('HGET', KEYS[1], 'localRemainingCredits') or '0')
                  redis.call('HSET', KEYS[1],
                      'grantedAmount', new_granted,
                      'localRemainingCredits', tostring(remaining + add))
              end
              if new_expiry > existing_expiry then
                  redis.call('HSET', KEYS[1], 'expiresAt', ARGV[3])
                  redis.call('PEXPIREAT', KEYS[1], new_expiry + grace)
              end
              return 0
          end

          redis.call('DEL', KEYS[1])
          redis.call('HSET', KEYS[1],
              'leaseId', new_id,
              'companyId', ARGV[5],
              'creditTypeId', ARGV[6],
              'grantedAmount', new_granted,
              'localRemainingCredits', new_granted,
              'expiresAt', ARGV[3])
          redis.call('PEXPIREAT', KEYS[1], new_expiry + grace)
          return 1
        LUA

        # Atomic check and decrement on localRemainingCredits. Returns
        # [post-debit balance, charged leaseId] on success, with the balance as
        # a string because a Lua number reply truncates to integer and would
        # corrupt fractional credit costs; a nil reply when there is no lease,
        # the lease has expired, or the remaining balance is short. Returning
        # the lease id read inside the same script is what lets the caller pin
        # its reservation to the lease the debit actually landed on.
        TRY_RESERVE_SCRIPT = Script.new(<<~LUA)

          redis.replicate_commands()
          local t = redis.call('TIME')
          local now = (tonumber(t[1]) * 1000) + math.floor(tonumber(t[2]) / 1000)

          local raw = redis.call('HGET', KEYS[1], 'localRemainingCredits')
          if not raw then return false end
          local lease_id = redis.call('HGET', KEYS[1], 'leaseId')
          if not lease_id then return false end
          local expiry = tonumber(redis.call('HGET', KEYS[1], 'expiresAt') or '0')
          if expiry <= now then return false end
          local remaining = tonumber(raw)
          local requested = tonumber(ARGV[1])
          if remaining < requested then return false end
          local new_remaining = remaining - requested
          redis.call('HSET', KEYS[1], 'localRemainingCredits', tostring(new_remaining))
          return { tostring(new_remaining), lease_id }
        LUA

        # Refund credits, clamped at grantedAmount. ARGV[2], when non-empty,
        # pins the refund to a leaseId: if the slot now holds a different lease,
        # the refund is dropped, because the expired lease's unspent remainder
        # was already returned to the company balance server-side.
        REFUND_SCRIPT = Script.new(<<~LUA)

          local raw_remaining = redis.call('HGET', KEYS[1], 'localRemainingCredits')
          if not raw_remaining then return 0 end
          local required_lease = ARGV[2]
          if required_lease and required_lease ~= '' then
              local current_lease = redis.call('HGET', KEYS[1], 'leaseId')
              if current_lease ~= required_lease then return 0 end
          end
          local remaining = tonumber(raw_remaining)
          local granted = tonumber(redis.call('HGET', KEYS[1], 'grantedAmount') or '0')
          local refund = tonumber(ARGV[1])
          local new_balance = remaining + refund
          if new_balance > granted then new_balance = granted end
          redis.call('HSET', KEYS[1], 'localRemainingCredits', tostring(new_balance))
          return 1
        LUA

        # Reconcile the lease to the server-authoritative grantedAmount total,
        # crediting the difference to localRemainingCredits. The delta is
        # computed HERE, atomically against the hash's current total, so two
        # processes extending the same lease concurrently converge instead of
        # minting phantom credits. Expiry only moves forward. ARGV[4] pins the
        # extend to a leaseId, mirroring the pin on the refund.
        EXTEND_SCRIPT = Script.new(<<~LUA)

          local raw_granted = redis.call('HGET', KEYS[1], 'grantedAmount')
          if not raw_granted then return 0 end
          local required_lease = ARGV[4]
          if required_lease and required_lease ~= '' then
              local current_lease = redis.call('HGET', KEYS[1], 'leaseId')
              if current_lease ~= required_lease then return 0 end
          end
          local granted = tonumber(raw_granted)
          local target = tonumber(ARGV[1])
          local add = target - granted
          if add > 0 then
              local remaining = tonumber(redis.call('HGET', KEYS[1], 'localRemainingCredits') or '0')
              redis.call('HSET', KEYS[1],
                  'grantedAmount', tostring(target),
                  'localRemainingCredits', tostring(remaining + add))
          end
          local new_expiry = tonumber(ARGV[2])
          local grace = tonumber(ARGV[3])
          local current_expiry = tonumber(redis.call('HGET', KEYS[1], 'expiresAt') or '0')
          if new_expiry > current_expiry then
              redis.call('HSET', KEYS[1], 'expiresAt', ARGV[2])
              redis.call('PEXPIREAT', KEYS[1], new_expiry + grace)
          end
          return 1
        LUA

        def initialize(client:, key_prefix: nil, default_lease_duration_ms: DEFAULT_LEASE_DURATION_MS,
                       clock: DEFAULT_CLOCK)
          @client = client
          @key_prefix = key_prefix || DEFAULT_KEY_PREFIX
          # Defensive fallback for a direct caller that extends without naming a
          # new expiry. The lease manager always passes one.
          @default_lease_duration_ms = default_lease_duration_ms
          @clock = clock
        end

        # Public so the reservation store can target the same lease hash.
        def hash_key(company_id, credit_type_id)
          "#{@key_prefix}#{LEASE_KEY_NAMESPACE}#{Leases.lease_key(company_id, credit_type_id)}"
        end

        def get(company_id, credit_type_id)
          raw = @client.hgetall(hash_key(company_id, credit_type_id))
          return nil if raw.nil? || raw["leaseId"].nil?

          decode_entry(raw)
        end

        # rubocop:disable Naming/PredicateMethod
        # replace is the store method name every Schematic SDK shares; its
        # boolean says whether a fresh row was written or an existing lease kept.
        def replace(entry)
          # No process clock here: the script reads now from the Redis server
          # via TIME, so every process agrees on expiry.
          result = REPLACE_SCRIPT.call(
            @client,
            keys: [hash_key(entry.company_id, entry.credit_type_id)],
            argv: [
              entry.lease_id,
              entry.granted_amount.to_s,
              millis(entry.expires_at).to_s,
              LEASE_TTL_GRACE_MS.to_s,
              entry.company_id,
              entry.credit_type_id
            ]
          )
          result.to_i == 1
        end
        # rubocop:enable Naming/PredicateMethod

        def extend(company_id, credit_type_id, granted_amount, new_expires_at = nil, pin_lease_id = nil)
          expiry = new_expires_at ? millis(new_expires_at) : millis(@clock.call) + @default_lease_duration_ms
          # granted_amount is the server-authoritative TOTAL; the script computes
          # the credit delta atomically against the stored total. An empty string
          # disables the lease pin, since Lua has no nil ARGV.
          EXTEND_SCRIPT.call(
            @client,
            keys: [hash_key(company_id, credit_type_id)],
            argv: [granted_amount.to_s, expiry.to_s, LEASE_TTL_GRACE_MS.to_s, pin_lease_id.to_s]
          )
          nil
        end

        def drop(company_id, credit_type_id)
          # A plain single-key delete: there is no secondary index to keep in sync.
          @client.del(hash_key(company_id, credit_type_id))
          nil
        end

        def try_reserve(company_id, credit_type_id, credits)
          # Reject non-finite or negative debits before they reach the script:
          # NaN.to_s parses back to a Lua nan, slips through the comparison, and
          # would poison the SHARED balance for every process.
          return nil unless Leases.valid_quantity?(credits)

          result = TRY_RESERVE_SCRIPT.call(
            @client,
            keys: [hash_key(company_id, credit_type_id)],
            # Only the requested amount: now comes from the Redis server clock.
            argv: [credits.to_s]
          )
          return nil if result.nil? || result == false

          ReserveResult.new(result[0].to_f, result[1].to_s)
        end

        def refund(company_id, credit_type_id, credits, pin_lease_id = nil)
          return nil if credits.nil? || credits <= 0

          REFUND_SCRIPT.call(
            @client,
            keys: [hash_key(company_id, credit_type_id)],
            # An empty string disables the lease pin, since Lua has no nil ARGV.
            argv: [credits.to_s, pin_lease_id.to_s]
          )
          nil
        end

        private

        def millis(time)
          (time.to_f * 1000).round
        end

        def decode_entry(raw)
          LeaseEntry.new(
            lease_id: raw["leaseId"],
            company_id: raw["companyId"],
            credit_type_id: raw["creditTypeId"],
            granted_amount: (raw["grantedAmount"] || 0).to_f,
            local_remaining_credits: (raw["localRemainingCredits"] || 0).to_f,
            expires_at: Time.at((raw["expiresAt"] || 0).to_f / 1000.0)
          )
        end
      end
    end
  end
end
