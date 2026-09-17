# frozen_string_literal: true

require "digest"
require "json"

# Shared test doubles for the credit lease suite: a virtual clock, an
# in-process Redis stand-in, and a scripted wire client.
module LeaseSupport
  # The fixed virtual instant every conformance vector and lease test starts
  # from. Vectors express every *_at_ms field as an offset from it.
  T0 = Time.utc(2026, 1, 1)

  # Only moves when a test advances it, so nothing here depends on wall time.
  class VirtualClock
    def initialize(start = T0)
      @now = start
      @mutex = Mutex.new
    end

    def now
      @mutex.synchronize { @now }
    end

    def to_proc
      -> { now }
    end

    def advance_ms(millis)
      @mutex.synchronize { @now += millis.to_f / 1000.0 }
    end

    # An absolute position on the virtual timeline.
    def at_ms(offset_ms)
      T0 + (offset_ms.to_f / 1000.0)
    end
  end

  # An in-process stand-in for Redis, covering the command subset the lease and
  # reservation stores use.
  #
  # Ruby has no fakeredis with a Lua interpreter (the Node and Python suites get
  # one from ioredis-mock and fakeredis respectively), so this fake dispatches
  # on the exact script source shipped by the stores and runs a Ruby
  # transliteration of it. The registry is keyed by that source, so a Lua change
  # that is not mirrored here fails loudly with "unknown script" instead of
  # silently diverging. The shipped Lua itself is what reaches a real Redis, and
  # test/credits_test.rb pins its SHA1 against the reference implementation's.
  class FakeRedis
    class NoScriptError < StandardError
    end

    def initialize(clock)
      @clock = clock
      @hashes = {}
      @zsets = {}
      @expiries = {}
      @scripts = {}
      @loaded = {}
      register_scripts
    end

    # --- string/hash commands -------------------------------------------------

    def hgetall(key)
      evict_expired
      (@hashes[key] || {}).dup
    end

    def hget(key, field)
      evict_expired
      (@hashes[key] || {})[field]
    end

    def hset(key, *pairs)
      evict_expired
      pairs = pairs.first.to_a.flatten(1) if pairs.size == 1 && pairs.first.is_a?(Hash)
      hash = (@hashes[key] ||= {})
      pairs.each_slice(2) { |field, value| hash[field.to_s] = value.to_s }
      pairs.size / 2
    end

    def hdel(key, field)
      evict_expired
      (@hashes[key] || {}).delete(field.to_s) ? 1 : 0
    end

    def del(*keys)
      evict_expired
      keys.count do |key|
        @expiries.delete(key)
        existed = @hashes.key?(key) || @zsets.key?(key)
        @hashes.delete(key)
        @zsets.delete(key)
        existed
      end
    end

    def exists?(key)
      evict_expired
      @hashes.key?(key) || @zsets.key?(key)
    end

    def pexpireat(key, millis)
      @expiries[key] = millis.to_i
      evict_expired
      1
    end

    # --- sorted set commands --------------------------------------------------

    def zadd(key, score, member)
      evict_expired
      zset = (@zsets[key] ||= {})
      added = zset.key?(member) ? 0 : 1
      zset[member] = score.to_f
      added
    end

    def zrem(key, member)
      evict_expired
      (@zsets[key] || {}).delete(member) ? 1 : 0
    end

    def zrangebyscore(key, min, max, limit: nil)
      evict_expired
      members = (@zsets[key] || {}).select { |_, score| score.between?(min.to_f, max.to_f) }
                                   .sort_by { |member, score| [score, member] }
                                   .map(&:first)
      return members if limit.nil?

      offset, count = limit
      members.drop(offset.to_i).first(count.to_i)
    end

    def zcard(key)
      evict_expired
      (@zsets[key] || {}).size
    end

    # --- scripting ------------------------------------------------------------

    # This is the Redis EVAL command, not Kernel#eval: it looks the script up in
    # a fixed registry of the store's own Lua and runs the matching Ruby
    # transliteration. Nothing is ever compiled from the argument.
    def eval(script, keys:, argv:)
      body = @scripts[script]
      raise "unknown script: #{Digest::SHA1.hexdigest(script)}" if body.nil?

      @loaded[Digest::SHA1.hexdigest(script)] = script
      evict_expired
      body.call(keys, argv.map(&:to_s))
    end

    def evalsha(sha, keys:, argv:)
      script = @loaded[sha]
      raise NoScriptError, "NOSCRIPT No matching script" if script.nil?

      eval(script, keys: keys, argv: argv) # rubocop:disable Security/Eval
    end

    # What the Lua reads from redis.call('TIME'), in integer milliseconds.
    def now_ms
      (@clock.now.to_f * 1000).round
    end

    private

    def evict_expired
      now = now_ms
      due = @expiries.select { |_, at| at <= now }.keys
      due.each do |key|
        @expiries.delete(key)
        @hashes.delete(key)
        @zsets.delete(key)
      end
    end

    def register_scripts
      lease = Schematic::Credits::Leases::RedisLeaseStore
      reservations = Schematic::Credits::Leases::RedisReservationStore
      @scripts[lease::REPLACE_SCRIPT.source] = method(:run_replace)
      @scripts[lease::TRY_RESERVE_SCRIPT.source] = method(:run_try_reserve)
      @scripts[lease::REFUND_SCRIPT.source] = method(:run_refund)
      @scripts[lease::EXTEND_SCRIPT.source] = method(:run_extend)
      @scripts[reservations::CLAIM_SCRIPT.source] = method(:run_claim)
    end

    def run_replace(keys, argv)
      key = keys.first
      existing_id = hget(key, "leaseId")
      existing_expiry = (hget(key, "expiresAt") || "0").to_f
      new_id, new_granted, new_expiry_raw, grace_raw, company_id, credit_type_id = argv
      new_expiry = new_expiry_raw.to_f
      grace = grace_raw.to_f

      return 0 if existing_id && existing_expiry > now_ms

      if existing_id == new_id
        granted = (hget(key, "grantedAmount") || "0").to_f
        add = new_granted.to_f - granted
        if add.positive?
          remaining = (hget(key, "localRemainingCredits") || "0").to_f
          hset(key, "grantedAmount", new_granted, "localRemainingCredits", (remaining + add).to_s)
        end
        if new_expiry > existing_expiry
          hset(key, "expiresAt", new_expiry_raw)
          pexpireat(key, new_expiry + grace)
        end
        return 0
      end

      del(key)
      hset(key, "leaseId", new_id, "companyId", company_id, "creditTypeId", credit_type_id,
           "grantedAmount", new_granted, "localRemainingCredits", new_granted, "expiresAt", new_expiry_raw)
      pexpireat(key, new_expiry + grace)
      1
    end

    def run_try_reserve(keys, argv)
      key = keys.first
      raw = hget(key, "localRemainingCredits")
      return nil if raw.nil?

      lease_id = hget(key, "leaseId")
      return nil if lease_id.nil?
      return nil if (hget(key, "expiresAt") || "0").to_f <= now_ms

      remaining = raw.to_f
      requested = argv[0].to_f
      return nil if remaining < requested

      new_remaining = remaining - requested
      hset(key, "localRemainingCredits", new_remaining.to_s)
      [new_remaining.to_s, lease_id]
    end

    def run_refund(keys, argv)
      key = keys.first
      raw_remaining = hget(key, "localRemainingCredits")
      return 0 if raw_remaining.nil?

      required_lease = argv[1]
      return 0 if required_lease && required_lease != "" && hget(key, "leaseId") != required_lease

      granted = (hget(key, "grantedAmount") || "0").to_f
      new_balance = raw_remaining.to_f + argv[0].to_f
      new_balance = granted if new_balance > granted
      hset(key, "localRemainingCredits", new_balance.to_s)
      1
    end

    def run_extend(keys, argv)
      key = keys.first
      raw_granted = hget(key, "grantedAmount")
      return 0 if raw_granted.nil?

      required_lease = argv[3]
      return 0 if required_lease && required_lease != "" && hget(key, "leaseId") != required_lease

      target = argv[0].to_f
      add = target - raw_granted.to_f
      if add.positive?
        remaining = (hget(key, "localRemainingCredits") || "0").to_f
        hset(key, "grantedAmount", target.to_s, "localRemainingCredits", (remaining + add).to_s)
      end
      new_expiry = argv[1].to_f
      grace = argv[2].to_f
      if new_expiry > (hget(key, "expiresAt") || "0").to_f
        hset(key, "expiresAt", argv[1])
        pexpireat(key, new_expiry + grace)
      end
      1
    end

    def run_claim(keys, _argv)
      key = keys.first
      raw = hgetall(key)
      return nil if raw.empty?

      del(key)
      raw.to_a.flatten(1)
    end
  end

  # Stands in for the lease API: queued responses in, recorded calls out.
  class ScriptedWireClient
    AcquireCall = Struct.new(:company_id, :credit_type_id, :requested_amount, :expires_at)
    ExtendCall = Struct.new(:lease_id, :additional_amount, :expires_at, :idempotency_key)

    attr_reader :acquire_calls, :extend_calls, :release_calls
    # Runs while an acquire is in flight, for emulating a sibling process
    # winning the race.
    attr_accessor :during_acquire

    def initialize(clock)
      @clock = clock
      @mutex = Mutex.new
      @acquire_responses = []
      @extend_responses = []
      @acquire_calls = []
      @extend_calls = []
      @release_calls = []
    end

    def queue_acquire(script)
      @mutex.synchronize { @acquire_responses << script }
    end

    def queue_extend(script)
      @mutex.synchronize { @extend_responses << script }
    end

    def acquire(company_id:, credit_type_id:, requested_amount:, expires_at:, **)
      during = nil
      script = @mutex.synchronize do
        @acquire_calls << AcquireCall.new(company_id, credit_type_id, requested_amount, expires_at)
        during = @during_acquire
        @during_acquire = nil
        @acquire_responses.shift
      end
      during&.call
      lease = scripted_lease(script, "unscripted acquire wire call")
      Schematic::Credits::Leases::LeaseGrant.new(
        lease_id: lease["lease_id"] || "lse_unnamed",
        company_id: company_id,
        credit_type_id: credit_type_id,
        granted_amount: lease["granted_amount"].to_f,
        expires_at: @clock.at_ms(lease["expires_at_ms"])
      )
    end

    def extend(lease_id:, additional_amount:, expires_at:, idempotency_key: nil, **)
      script = @mutex.synchronize do
        @extend_calls << ExtendCall.new(lease_id, additional_amount, expires_at, idempotency_key)
        @extend_responses.shift
      end
      lease = scripted_lease(script, "unscripted extend wire call")
      granted = lease["granted_total"] || lease["granted_amount"]
      Schematic::Credits::Leases::LeaseGrant.new(
        lease_id: lease_id,
        company_id: "co_wire",
        credit_type_id: "ct_wire",
        granted_amount: granted.to_f,
        expires_at: @clock.at_ms(lease["expires_at_ms"])
      )
    end

    def release(lease_id:, **)
      @mutex.synchronize { @release_calls << lease_id }
      nil
    end

    private

    def scripted_lease(script, missing)
      raise missing if script.nil?
      raise(script["error"] || missing) if script["error"] || script["lease"].nil?

      script["lease"]
    end
  end

  # Serves one flag and one company from "cache" and answers each evaluation
  # with the next scripted result, in call order.
  #
  # The engine is an oracle here, as conformance/SPEC.md says: the vectors pin
  # the orchestration around the rules engine, not the engine itself, which is
  # shared WASM across the SDKs and has its own tests.
  class ScriptedDataStream
    EngineCall = Struct.new(:credit_balances, :options)

    attr_reader :calls

    def initialize(flag_key:, company:, results:, user: nil)
      @flag_key = flag_key
      @company = company
      @user = user
      @results = results.dup
      @calls = []
    end

    def get_flag(_key)
      { id: "flag_1", key: @flag_key }
    end

    def get_company(_keys)
      @company
    end

    def get_user(_keys)
      @user
    end

    def check_flag_with_options(_flag, company, _user, options)
      @calls << EngineCall.new((company || {})[:credit_balances] || {}, options)
      raise "unscripted engine call for flag #{@flag_key}" if @results.empty?

      scripted = @results.shift
      {
        value: scripted["value"],
        reason: scripted["reason"],
        flag_key: @flag_key,
        flag_id: "flag_1",
        entitlement: entitlement_from(scripted["entitlement"])
      }
    end

    private

    def entitlement_from(spec)
      return nil if spec.nil?

      {
        featureId: spec["feature_id"] || "feat_1",
        featureKey: spec["feature_key"] || @flag_key,
        valueType: spec["value_type"],
        creditId: spec["credit_id"],
        consumptionRate: spec["consumption_rate"],
        eventSubtype: spec["event_subtype"],
        metricResetAt: spec["metric_reset_at"]
      }.compact
    end
  end

  # A lease-store refunder that fails once while armed, reproducing a process
  # death between a reservation's claim and its refund. The reservation store
  # refunds through whatever it is handed, so wrapping the store leaves the rest
  # of the flow reading the real one.
  class CrashingRefund
    class SimulatedCrash < StandardError
    end

    def initialize(target)
      @target = target
      @armed = false
    end

    def arm
      @armed = true
    end

    def refund(company_id, credit_type_id, credits, pin_lease_id = nil)
      if @armed
        @armed = false
        raise SimulatedCrash, "simulated crash before refund"
      end
      @target.refund(company_id, credit_type_id, credits, pin_lease_id)
    end

    # Everything else the reservation store might reach for goes straight
    # through, so the wrapper is only a seam for the refund.
    def method_missing(name, ...)
      return super unless @target.respond_to?(name)

      @target.public_send(name, ...)
    end

    def respond_to_missing?(name, include_private = false)
      @target.respond_to?(name, include_private) || super
    end
  end
end
