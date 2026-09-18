# frozen_string_literal: true

require "minitest/autorun"
require "webmock/minitest"

# Requiring WebMock blocks outbound HTTP for the whole suite, and the default
# rake run also covers a raw-client test that talks to a throwaway server on
# loopback. Leave that alone; every stub here targets a remote host.
WebMock.disable_net_connect!(allow_localhost: true)
require "digest"
require_relative "../lib/schematichq"
require_relative "lease_support"

# Unit coverage for credit leases, reservations, and preflight checks. The
# conformance vectors in test/conformance_test.rb pin the cross-SDK semantics;
# these cover what a vector cannot: concurrency, wire shapes, client wiring, and
# the Redis key layout.
module CreditTestHelpers
  Leases = Schematic::Credits::Leases

  def silent_logger
    Schematic::ConsoleLogger.new(level: :error)
  end

  # Captures warnings so a test can assert the SDK said something about a
  # misconfiguration rather than correcting it in silence.
  class RecordingLogger
    attr_reader :warnings

    def initialize
      @warnings = []
    end

    def warn(message)
      @warnings << message
    end

    def error(_message); end
    def debug(_message); end
    def info(_message); end
  end

  def clock
    @clock ||= LeaseSupport::VirtualClock.new
  end

  def lease_entry(lease_id: "lse_1", company_id: "co_1", credit_type_id: "ct_1", granted_amount: 1000,
                  expires_at_ms: 300_000)
    Leases::LeaseEntry.new(
      lease_id: lease_id, company_id: company_id, credit_type_id: credit_type_id,
      granted_amount: granted_amount, expires_at: clock.at_ms(expires_at_ms)
    )
  end

  UUID_SHAPE = /\A\h{8}-\h{4}-\h{4}-\h{4}-\h{12}\z/

  # Collects the idempotency key off every attempt WebMock sees, so a test can
  # tell "one key, several attempts" from "a key per attempt".
  def record_idempotency_keys(stub, sink)
    stub.with do |req|
      sink << JSON.parse(req.body)["idempotency_key"]
      true
    end
  end

  def reservation(id: "res_1", lease_id: "lse_1", credits_reserved: 100, expires_at_ms: 60_000,
                  consumption_rate: 10, mode: nil)
    Leases::Reservation.new(
      id: id, lease_id: lease_id, mode: mode, company_id: "co_1", credit_type_id: "ct_1",
      event_subtype: "inference_tokens", quantity_reserved: credits_reserved / consumption_rate,
      credits_reserved: credits_reserved, consumption_rate: consumption_rate,
      expires_at: clock.at_ms(expires_at_ms), eval_ctx: { company: { "id" => "co_1" } }
    )
  end
end

# A Lua change that is not mirrored into a real Redis would split a
# mixed-language fleet's lease in two, so the shipped script text is pinned
# against the reference implementation's byte for byte.
class LeaseScriptIdentityTest < Minitest::Test
  include CreditTestHelpers

  # SHA1 of each script as schematic-node ships it. Recompute from that repo,
  # never from this one, if the scripts ever legitimately change.
  REFERENCE_SHAS = {
    "REPLACE_SCRIPT" => "96e6830dd5664bee5700e30d64f04b1726b37c3f",
    "TRY_RESERVE_SCRIPT" => "53d744e6e38eca7fc26462fd7e8b5e70bbdfb642",
    "REFUND_SCRIPT" => "43873b5f916a0ec012d9377af400e1ecc0b3ec0d",
    "EXTEND_SCRIPT" => "842913369460707b70475b6853d996687878b7eb"
  }.freeze

  def test_lease_scripts_match_the_reference_implementation
    REFERENCE_SHAS.each do |name, sha|
      assert_equal sha, Leases::RedisLeaseStore.const_get(name).sha, "#{name} diverged from schematic-node"
    end
  end

  def test_claim_script_matches_the_reference_implementation
    assert_equal "b89cdd478995f79d7fd6e5534d434ca08d214c6c", Leases::RedisReservationStore::CLAIM_SCRIPT.sha
  end

  # A script is addressed by its SHA so the body is not resent on every call; a
  # Redis that has never seen it answers NOSCRIPT and the body goes out once.
  def test_script_falls_back_to_eval_when_redis_has_not_loaded_it
    redis = LeaseSupport::FakeRedis.new(clock)
    store = Leases::RedisLeaseStore.new(client: redis, clock: clock.to_proc)

    assert store.replace(lease_entry)
    # The second call finds the script cached under its SHA.
    refute store.replace(lease_entry(lease_id: "lse_2"))
  end
end

# Every integer field on the wire goes through wire_quantity, so its rounding
# is what decides what a caller is billed.
class WireQuantityTest < Minitest::Test
  include CreditTestHelpers

  def test_a_partial_unit_rounds_up
    assert_equal 2, Leases.wire_quantity(1.2)
    assert_equal 1, Leases.wire_quantity(0.0001)
  end

  # (0.1 + 0.2) * 10 is 3.0000000000000004, and a bare ceil would bill it as 4.
  def test_float_noise_does_not_cost_a_whole_unit
    assert_equal 3, Leases.wire_quantity((0.1 + 0.2) * 10)
    assert_equal 1, Leases.wire_quantity(1.0000000000000002)
    assert_equal 10, Leases.wire_quantity(10.0)
  end

  def test_integers_and_non_numbers_pass_through
    assert_equal 7, Leases.wire_quantity(7)
    assert_equal 0, Leases.wire_quantity(0)
    # Not finite, so it is handed back untouched rather than raising in ceil.
    assert_predicate Leases.wire_quantity(Float::INFINITY), :infinite?
    assert_predicate Leases.wire_quantity(Float::NAN), :nan?
  end
end

# The engine deserializes usage and event_usage.quantity as i64, so a value
# with a decimal point fails the whole check.
class EngineQuantityTest < Minitest::Test
  def options
    Schematic::RulesEngine.new.send(
      :engine_options,
      { credit_cost: { "ct_1" => 2.5 }, usage: 0.5, event_usage: { event_subtype: "tokens", quantity: 1.2 } }
    )
  end

  def test_a_fractional_preflight_quantity_rounds_up
    assert_equal 1, options[:usage]
    assert_equal 2, options[:event_usage][:quantity]
  end

  # The cost is credits, not event units, and the engine takes it as a float.
  def test_the_credit_cost_is_left_alone
    assert_in_delta 2.5, options[:credit_cost]["ct_1"]
  end
end

class LeaseStoreTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @store = Leases::LeaseStore.new(clock: clock.to_proc)
  end

  def test_try_reserve_rejects_a_nan_debit
    @store.replace(lease_entry)

    assert_nil @store.try_reserve("co_1", "ct_1", Float::NAN)
    assert_in_delta 1000, @store.get("co_1", "ct_1").local_remaining_credits
  end

  def test_try_reserve_rejects_an_infinite_debit
    @store.replace(lease_entry)

    assert_nil @store.try_reserve("co_1", "ct_1", Float::INFINITY)
  end

  def test_concurrent_reserves_never_oversell_the_lease
    @store.replace(lease_entry(granted_amount: 100))
    threads = 20.times.map do
      Thread.new { @store.try_reserve("co_1", "ct_1", 10) }
    end
    granted = threads.map(&:value).compact

    assert_equal 10, granted.size
    assert_in_delta 0, @store.get("co_1", "ct_1").local_remaining_credits
  end

  def test_get_returns_a_copy_a_caller_cannot_mutate_the_store_through
    @store.replace(lease_entry)
    entry = @store.get("co_1", "ct_1")
    entry.local_remaining_credits = 0

    assert_in_delta 1000, @store.get("co_1", "ct_1").local_remaining_credits
  end

  def test_list_enumerates_every_slot
    @store.replace(lease_entry)
    @store.replace(lease_entry(lease_id: "lse_2", credit_type_id: "ct_2"))

    assert_equal %w[lse_1 lse_2], @store.list.map(&:lease_id).sort
  end

  # A process checking flags for companies that never lease must not collect a
  # mutex per slot it merely asked about, or pruning only half works.
  def test_reading_a_slot_with_no_lease_registers_no_lock
    assert_nil @store.get("co_missing", "ct_1")
    assert_nil @store.try_reserve("co_missing", "ct_1", 10)
    assert_nil @store.refund("co_missing", "ct_1", 10)

    assert_empty @store.instance_variable_get(:@locks)
  end

  # A long-lived process leases for many companies, and a mutex per slot it has
  # ever touched is a leak.
  def test_dropping_a_lease_prunes_its_lock
    @store.replace(lease_entry)
    @store.try_reserve("co_1", "ct_1", 10)

    @store.drop("co_1", "ct_1")

    assert_empty @store.instance_variable_get(:@locks)
  end

  # Pruning under the slot's own mutex strands anyone already blocked on it, so
  # a waiter has to notice and retry against the mutex the table now holds.
  # Without that, the waiter and a newcomer would run side by side on one slot.
  def test_a_waiter_on_a_pruned_lock_retries_against_the_current_one
    locks = @store.instance_variable_get(:@locks)
    table = @store.instance_variable_get(:@table_mutex)
    held = Queue.new
    release = Queue.new
    order = []

    holder = Thread.new do
      @store.send(:with_lock, "co_1:ct_1") do
        held << true
        release.pop
        # Exactly what drop does: prune while holding the very mutex it prunes.
        table.synchronize { locks.delete("co_1:ct_1") }
        order << :holder
      end
    end
    held.pop
    waiter = Thread.new { @store.send(:with_lock, "co_1:ct_1") { order << :waiter } }
    # Let the waiter block on the mutex that is about to be pruned.
    sleep 0.05
    release << true
    [holder, waiter].each(&:join)

    assert_equal %i[holder waiter], order
    # The waiter re-registered a mutex for the slot, which it could only do by
    # noticing the one it woke holding was stale.
    refute_empty locks
  end
end

class ReservationStoreTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @leases = Leases::LeaseStore.new(clock: clock.to_proc)
    @leases.replace(lease_entry)
    @store = Leases::ReservationStore.new(@leases, 1000, clock: clock.to_proc)
  end

  def teardown
    @store.stop
  end

  # The claim is the arbiter, so of two racing settles only one refunds.
  def test_consume_is_exactly_once
    @leases.try_reserve("co_1", "ct_1", 100)
    @store.add(reservation)

    assert_in_delta 0, @store.consume("res_1", 0)
    assert_nil @store.consume("res_1", 0)
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  def test_sweep_refunds_only_expired_holds
    @leases.try_reserve("co_1", "ct_1", 200)
    @store.add(reservation(id: "res_1", credits_reserved: 100, expires_at_ms: 10_000))
    @store.add(reservation(id: "res_2", credits_reserved: 100, expires_at_ms: 90_000))
    clock.advance_ms(60_000)

    assert_equal 1, @store.sweep_expired
    assert_in_delta 900, @leases.get("co_1", "ct_1").local_remaining_credits
    assert_in_delta 100, @store.reserved_credits("co_1", "ct_1")
  end

  # The sweeper must not keep the process alive, and stopping it twice is safe.
  def test_start_and_stop_sweep_are_idempotent
    @store.start_sweep
    @store.start_sweep
    @store.stop
    @store.stop
  end

  # A fork (Puma or Unicorn with preload) hands the child a thread object whose
  # thread did not survive, and holds would then pile up unswept in the child.
  def test_a_sweeper_that_did_not_survive_a_fork_starts_again
    dead = Thread.new { nil }
    dead.join
    @store.instance_variable_set(:@sweep_thread, dead)

    @store.start_sweep

    assert_predicate @store.instance_variable_get(:@sweep_thread), :alive?
  ensure
    @store.stop
  end
end

# The sweeper deletes a reservation and then refunds its lease. Killing it
# between the two strands the unspent slice until the lease expires, so stop
# gives it a bounded moment to land the refund first.
class ReservationSweepStopTest < Minitest::Test
  include CreditTestHelpers

  def test_stop_lets_a_sweep_in_progress_land_its_refund
    refunding = Queue.new
    refunded = []
    leases = Leases::LeaseStore.new(clock: clock.to_proc)
    leases.replace(lease_entry)
    slow = Object.new
    slow.define_singleton_method(:refund) do |company_id, credit_type_id, credits, pin_lease_id = nil|
      refunding << true
      # The window a kill would land in.
      sleep 0.05
      refunded << credits
      leases.refund(company_id, credit_type_id, credits, pin_lease_id)
    end
    store = Leases::ReservationStore.new(slow, 10, clock: clock.to_proc, logger: silent_logger)
    store.add(reservation(expires_at_ms: 0))
    store.start_sweep
    refunding.pop

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    store.stop
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    assert_equal [100.0], refunded
    assert_in_delta 1000, leases.get("co_1", "ct_1").local_remaining_credits
    # And still returns promptly: the join is bounded, not open-ended.
    assert_operator elapsed_ms, :<, 400
  end

  # Nothing to wait for is the common case, and it must not cost the join
  # budget.
  def test_stop_returns_at_once_when_no_sweep_is_running
    store = Leases::ReservationStore.new(Leases::LeaseStore.new(clock: clock.to_proc), 1000,
                                         clock: clock.to_proc, logger: silent_logger)

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    store.stop
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    assert_operator elapsed_ms, :<, 50
  end
end

# EVALSHA is retried with the full script body on NOSCRIPT alone. Any other
# error is the script's own: replaying it could debit a second time.
class ScriptFallbackTest < Minitest::Test
  include CreditTestHelpers

  def test_a_noscript_error_reloads_the_script
    script = Leases::Script.new("return 1")
    client = Object.new
    def client.evalsha(_sha, **) = raise("NOSCRIPT No matching script")
    def client.eval(_source, **) = "loaded"

    assert_equal "loaded", script.call(client, keys: [], argv: [])
  end

  def test_any_other_error_is_raised_rather_than_retried
    script = Leases::Script.new("return 1")
    client = Object.new
    def client.evalsha(_sha, **) = raise("ERR Lua script attempted to access nonexistent key")
    def client.eval(_source, **) = raise("a retry could debit twice")

    error = assert_raises(RuntimeError) { script.call(client, keys: [], argv: []) }

    assert_match(/nonexistent key/, error.message)
  end
end

class RedisStoreLayoutTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @redis = LeaseSupport::FakeRedis.new(clock)
    @leases = Leases::RedisLeaseStore.new(client: @redis, key_prefix: "acme:", clock: clock.to_proc)
    @reservations = Leases::RedisReservationStore.new(client: @redis, lease_store: @leases, key_prefix: "acme:",
                                                      clock: clock.to_proc)
  end

  # Lua's tonumber reads a decimal string, and a Rational renders as "1/2",
  # which the script reads as nil and treats as a zero.
  def test_a_rational_amount_reaches_the_script_as_a_decimal
    @leases.replace(lease_entry(granted_amount: Rational(3, 2)))

    assert_in_delta 1.5, @leases.get("co_1", "ct_1").granted_amount
    assert_in_delta 1.5, @leases.get("co_1", "ct_1").local_remaining_credits
    refute_nil @leases.try_reserve("co_1", "ct_1", Rational(1, 2))
    assert_in_delta 1.0, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # The key layout is what lets a mixed-language fleet share one lease per slot.
  def test_lease_hash_key_layout
    assert_equal "acme:credit-lease:co_1:ct_1", @leases.hash_key("co_1", "ct_1")
  end

  def test_reservation_add_writes_the_hash_and_both_indexes
    @leases.replace(lease_entry)
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    assert_equal "lse_1", @redis.hgetall("acme:credit-reservation:res_1")["leaseId"]
    assert_equal ["co_1|ct_1|res_1"], @redis.zrangebyscore("acme:credit-reservations:byExpiry", 0, 1e18)
    assert_in_delta 100, @reservations.reserved_credits("co_1", "ct_1")
  end

  # Written separately, a crash between the two leaves a row that never expires
  # and that nothing points at once the sweeper drops its index entry.
  def test_reservation_add_writes_the_hash_and_its_ttl_in_one_transaction
    @leases.replace(lease_entry)
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    assert_equal [%i[hset pexpireat]], @redis.transactions
    assert_equal "res_1", @reservations.get("res_1").id
  end

  # The row outlives its declared expiry by the grace window so the sweeper can
  # still read it, but an expired-but-not-evicted lease must refuse a reserve.
  def test_expired_lease_within_the_grace_window_refuses_a_reserve
    @leases.replace(lease_entry(expires_at_ms: 1000))
    clock.advance_ms(2000)

    assert_nil @leases.try_reserve("co_1", "ct_1", 1)
    refute_nil @leases.get("co_1", "ct_1")
  end

  def test_lease_row_is_evicted_after_the_grace_window
    @leases.replace(lease_entry(expires_at_ms: 1000))
    clock.advance_ms(1000 + Leases::RedisLeaseStore::LEASE_TTL_GRACE_MS + 1)

    assert_nil @leases.get("co_1", "ct_1")
  end

  # Without the reservation hash the claim cannot arbitrate exactly-once across
  # racing sweepers, so the orphaned index field is reconciled, not refunded.
  def test_sweep_reconciles_an_evicted_hold_without_refunding_it
    @leases.replace(lease_entry)
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation(expires_at_ms: 1000))
    clock.advance_ms(1000 + Leases::RedisReservationStore::RES_TTL_GRACE_MS + 1)

    assert_equal 0, @reservations.sweep_expired
    assert_in_delta 0, @reservations.reserved_credits("co_1", "ct_1")
    assert_in_delta 900, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # A shared store is never enumerated: sibling processes may still be drawing
  # on those leases, so close must not be able to release them.
  def test_redis_store_does_not_expose_list
    refute_respond_to @leases, :list
  end
end

class LeaseManagerTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @wire = LeaseSupport::ScriptedWireClient.new(clock)
    @leases = Leases::LeaseStore.new(clock: clock.to_proc)
    @manager = Leases::LeaseManager.new(
      wire_client: @wire, lease_store: @leases, logger: silent_logger,
      config: { default_lease_size: 1000, default_lease_duration: 300_000, low_water_mark: 0.25 },
      clock: clock.to_proc
    )
  end

  def teardown
    @manager.stop
  end

  def acquire_script(lease_id: "lse_1", granted_amount: 1000, expires_at_ms: 300_000)
    { "lease" => { "lease_id" => lease_id, "granted_amount" => granted_amount,
                   "expires_at_ms" => expires_at_ms } }
  end

  # Callers arriving while a wire call is in flight share it rather than opening
  # a second lease.
  def test_concurrent_acquires_share_one_wire_call
    started = Queue.new
    release = Queue.new
    @wire.queue_acquire(acquire_script)
    @wire.during_acquire = -> do
      started << true
      release.pop
    end

    first = Thread.new { @manager.acquire_if_needed("co_1", "ct_1") }
    started.pop
    joiner = Thread.new { @manager.acquire_if_needed("co_1", "ct_1") }
    # Give the joiner time to register against the flight before it lands.
    sleep 0.05
    release << true

    assert_equal "lse_1", first.value.lease_id
    assert_equal "lse_1", joiner.value.lease_id
    assert_equal 1, @wire.acquire_calls.size
  end

  # A store outage answering "due" would spawn a thread per check, and each
  # would only fail the same read again.
  def test_no_thread_is_spawned_when_the_store_cannot_be_read
    broken = Object.new
    def broken.get(_company_id, _credit_type_id) = raise("redis down")
    manager = Leases::LeaseManager.new(wire_client: @wire, lease_store: broken, logger: silent_logger,
                                       clock: clock.to_proc)

    assert_nil manager.maybe_extend_in_background("co_1", "ct_1")
    assert_empty @wire.extend_calls
  ensure
    manager&.stop
  end

  # Most checks sit nowhere near the water mark, so learning that must not cost
  # a thread each.
  def test_no_thread_is_spawned_when_no_extend_is_due
    @leases.replace(lease_entry(granted_amount: 1000))

    assert_nil @manager.maybe_extend_in_background("co_1", "ct_1")
    assert_empty @wire.extend_calls
  end

  # Watermark refreshes arriving during one slow extend have nothing to wait
  # for: the credits they want are the ones that call is fetching.
  def test_watermark_refreshes_during_one_extend_make_one_wire_call
    @leases.replace(lease_entry(granted_amount: 1000))
    # Draw the slot down under the water mark.
    @leases.try_reserve("co_1", "ct_1", 900)
    started = Queue.new
    release = Queue.new
    @wire.queue_extend({ "lease" => { "lease_id" => "lse_1", "granted_amount" => 2000,
                                      "expires_at_ms" => 300_000 } })
    @wire.during_extend = -> do
      started << true
      release.pop
    end

    first = @manager.maybe_extend_in_background("co_1", "ct_1")
    started.pop
    followers = Array.new(10) { @manager.maybe_extend_in_background("co_1", "ct_1") }
    release << true
    ([first] + followers).compact.each(&:join)

    assert_equal 1, @wire.extend_calls.size
    # No thread each: the credits they want are the ones the flight is already
    # fetching, so there is nothing for a thread to do but find it and exit.
    assert_empty followers.compact
  end

  # A caller naming required_credits still spawns while a flight runs: it has a
  # reserve to retry, and may need more than that flight asked for.
  def test_a_check_naming_its_shortfall_still_spawns_during_one_extend
    @leases.replace(lease_entry(granted_amount: 1000))
    @leases.try_reserve("co_1", "ct_1", 900)
    started = Queue.new
    release = Queue.new
    2.times do
      @wire.queue_extend({ "lease" => { "lease_id" => "lse_1", "granted_total" => 20_000,
                                        "expires_at_ms" => 300_000 } })
    end
    @wire.during_extend = -> do
      started << true
      release.pop
    end

    first = @manager.maybe_extend_in_background("co_1", "ct_1")
    started.pop
    joiner = @manager.maybe_extend_in_background("co_1", "ct_1", 5000)
    release << true

    refute_nil joiner
    [first, joiner].compact.each(&:join)
  end

  # A follow-up that joins a flight asking for less than it needs, and finds
  # another equally small follow-up on the way round, must still end with an
  # extend of its own: returning the small one leaves its retry short with
  # credits sitting on the server.
  def test_a_follow_up_waits_out_a_too_small_flight_and_then_extends_itself
    @leases.replace(lease_entry(granted_amount: 1000))
    @leases.try_reserve("co_1", "ct_1", 1000)
    key = Leases.lease_key("co_1", "ct_1")
    inflight = @manager.instance_variable_get(:@inflight_extend)
    inflight[key] = Leases::Flight.new(2000)
    # The second read is the caller waking from that flight: by then another
    # caller's follow-up, just as small, holds the slot.
    reads = 0
    leases = @leases
    @leases.define_singleton_method(:get) do |company_id, credit_type_id|
      reads += 1
      if reads == 2
        landed = Leases::Flight.new(2000)
        landed.complete(leases.get("co_1", "ct_1"))
        inflight[key] = landed
      end
      super(company_id, credit_type_id)
    end
    @wire.queue_extend({ "lease" => { "lease_id" => "lse_1", "granted_total" => 19_000,
                                      "expires_at_ms" => 600_000 } })

    waiter = Thread.new { @manager.send(:extend_if_needed, "co_1", "ct_1", 18_000, nil) }
    inflight[key].complete(@leases.get("co_1", "ct_1"))
    entry = waiter.value

    assert_equal 1, @wire.extend_calls.size
    assert_in_delta 18_000, @wire.extend_calls.first.additional_amount
    assert_in_delta 18_000, entry.local_remaining_credits
  end

  # A joiner waits on a call started by someone else, on someone else's timeout.
  # A check with a budget of its own must not sit behind it.
  def test_a_joiner_gives_up_on_a_shared_extend_at_its_own_timeout
    @leases.replace(lease_entry(granted_amount: 1000))
    @leases.try_reserve("co_1", "ct_1", 1000)
    key = Leases.lease_key("co_1", "ct_1")
    flight = Leases::Flight.new(2000)
    @manager.instance_variable_get(:@inflight_extend)[key] = flight

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    entry = @manager.send(:extend_if_needed, "co_1", "ct_1", 18_000, { timeout_in_seconds: 0.05 })
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    # No entry, so the check takes its failure path by mode, and the flight is
    # left running for whoever else is on it.
    assert_nil entry
    assert_operator elapsed_ms, :<, 1000
    refute_predicate flight, :done?
    assert_empty @wire.extend_calls
  end

  # stop and enlist share the flight lock, so once stop returns no acquire can
  # register behind the drain that follows it.
  def test_an_acquire_cannot_register_once_the_manager_is_stopped
    @manager.stop
    @wire.queue_acquire(acquire_script)

    assert_nil @manager.acquire_if_needed("co_1", "ct_1")
    assert_empty @wire.acquire_calls
  end

  # A stop landing mid-acquire leaves the lease installed, for the drain that
  # follows or for server-side expiry. Releasing it here would refund a lease
  # sibling processes sharing the backend are still reserving against.
  def test_a_lease_acquired_during_a_stop_is_left_for_the_drain
    @wire.queue_acquire(acquire_script)
    manager = @manager
    @wire.during_acquire = -> { manager.stop }

    @manager.acquire_if_needed("co_1", "ct_1")

    assert_empty @wire.release_calls
    assert_equal "lse_1", @leases.get("co_1", "ct_1").lease_id
  end

  # The drain budget is what a caller asked close to take in total. Spending it
  # thread by thread would multiply it by however many are stalled.
  def test_drain_bounds_the_total_wait_across_stalled_threads
    release = Queue.new
    5.times { @manager.send(:track) { release.pop } }

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @manager.drain(300)
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    # One budget, not five. The ceiling is loose enough for scheduling noise and
    # far below the 1500ms a per-thread budget would cost.
    assert_operator elapsed_ms, :<, 900
  ensure
    5.times { release << true }
  end

  def test_acquire_returns_nil_rather_than_raising_when_the_wire_fails
    @wire.queue_acquire({ "error" => "wire down" })

    assert_nil @manager.acquire_if_needed("co_1", "ct_1")
  end

  def test_acquire_is_refused_once_the_manager_is_stopped
    @manager.stop
    @wire.queue_acquire(acquire_script)

    assert_nil @manager.acquire_if_needed("co_1", "ct_1")
    assert_empty @wire.acquire_calls
  end

  # The server treats an expired lease as released and has already refunded its
  # remainder, so extending it would resurrect a stale local row.
  def test_expired_leases_are_never_extended
    @leases.replace(lease_entry(granted_amount: 1000, expires_at_ms: 1000))
    @leases.try_reserve("co_1", "ct_1", 900)
    clock.advance_ms(2000)

    @manager.maybe_extend_in_background("co_1", "ct_1")&.join

    assert_empty @wire.extend_calls
  end

  # An extend is an increment, so every attempt of one extend must carry the
  # same key while a later extend gets its own.
  def test_each_extend_mints_a_fresh_idempotency_key
    @leases.replace(lease_entry(granted_amount: 1000))
    @leases.try_reserve("co_1", "ct_1", 900)
    @wire.queue_extend({ "lease" => { "granted_total" => 2000, "expires_at_ms" => 600_000 } })
    @manager.maybe_extend_in_background("co_1", "ct_1")&.join

    @leases.try_reserve("co_1", "ct_1", 1000)
    @wire.queue_extend({ "lease" => { "granted_total" => 3000, "expires_at_ms" => 900_000 } })
    @manager.maybe_extend_in_background("co_1", "ct_1")&.join

    keys = @wire.extend_calls.map(&:idempotency_key)

    assert_equal 2, keys.compact.uniq.size
  end

  def test_release_all_local_leases_skips_expired_and_drops_released
    @leases.replace(lease_entry(lease_id: "lse_live"))
    @leases.replace(lease_entry(lease_id: "lse_dead", credit_type_id: "ct_2", expires_at_ms: 1000))
    clock.advance_ms(2000)

    @manager.release_all_local_leases

    assert_equal [], @wire.release_calls - ["lse_live"]
    assert_equal ["lse_dead"], @leases.list.map(&:lease_id)
  end

  # A shared store never reports its contents, so there is nothing for the close
  # to release out from under a sibling process.
  def test_release_all_local_leases_is_a_no_op_without_an_enumerable_store
    shared = Leases::RedisLeaseStore.new(client: LeaseSupport::FakeRedis.new(clock), clock: clock.to_proc)
    manager = Leases::LeaseManager.new(wire_client: @wire, lease_store: shared, logger: silent_logger,
                                       config: {}, clock: clock.to_proc)
    shared.replace(lease_entry)

    manager.release_all_local_leases

    assert_empty @wire.release_calls
  end

  def test_drain_returns_once_background_work_has_landed
    @leases.replace(lease_entry(granted_amount: 1000))
    @leases.try_reserve("co_1", "ct_1", 900)
    @wire.queue_extend({ "lease" => { "granted_total" => 2000, "expires_at_ms" => 600_000 } })
    @manager.maybe_extend_in_background("co_1", "ct_1")

    @manager.drain

    assert_equal 1, @wire.extend_calls.size
    assert_in_delta 1100, @leases.get("co_1", "ct_1").local_remaining_credits
  end
end

class WireClientTest < Minitest::Test
  include CreditTestHelpers

  LEASE_BODY = {
    "data" => {
      "id" => "lse_1", "company_id" => "co_1", "credit_type_id" => "ct_1",
      "granted_amount" => 1000, "tracked_amount" => 0,
      "expires_at" => "2026-01-01T00:05:00Z", "created_at" => "2026-01-01T00:00:00Z",
      "updated_at" => "2026-01-01T00:00:00Z"
    },
    "params" => {}
  }.freeze

  def setup
    @client = Schematic::Client.new(api_key: "sch_test", base_url: "https://api.schematichq.test")
    @wire = Leases::ApiWireClient.new(credits_client: @client.credits)
  end

  def test_acquire_sends_the_requested_amount_and_expiry
    stub_request(:post, "https://api.schematichq.test/billing/credits/lease")
      .to_return(status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" })

    grant = @wire.acquire(company_id: "co_1", credit_type_id: "ct_1", requested_amount: 1000,
                          expires_at: Time.utc(2026, 1, 1, 0, 5))

    assert_equal "lse_1", grant.lease_id
    assert_in_delta 1000, grant.granted_amount
    assert_equal Time.utc(2026, 1, 1, 0, 5), grant.expires_at
    assert_requested(:post, "https://api.schematichq.test/billing/credits/lease") do |req|
      body = JSON.parse(req.body)
      body["company_id"] == "co_1" && body["requested_amount"] == 1000 &&
        body["expires_at"] == "2026-01-01T00:05:00Z"
    end
  end

  def test_extend_sends_the_additional_amount
    stub_request(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend")
      .to_return(status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" })

    @wire.extend(lease_id: "lse_1", additional_amount: 500, expires_at: Time.utc(2026, 1, 1, 0, 5),
                 idempotency_key: "key-1")

    assert_requested(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend") do |req|
      body = JSON.parse(req.body)
      body["additional_amount"] == 500 && body["idempotency_key"] == "key-1"
    end
  end

  # A shortfall of 10.4 asked for as 10 leaves the retried reserve short by the
  # same fraction every time, so the ask rounds up.
  def test_a_fractional_amount_rounds_up_on_both_calls
    stub_request(:post, "https://api.schematichq.test/billing/credits/lease")
      .to_return(status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" })
    stub_request(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend")
      .to_return(status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" })

    @wire.acquire(company_id: "co_1", credit_type_id: "ct_1", requested_amount: 10.4,
                  expires_at: Time.utc(2026, 1, 1, 0, 5))
    @wire.extend(lease_id: "lse_1", additional_amount: 10.4, expires_at: Time.utc(2026, 1, 1, 0, 5))

    assert_requested(:post, "https://api.schematichq.test/billing/credits/lease") do |req|
      JSON.parse(req.body)["requested_amount"] == 11
    end
    assert_requested(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend") do |req|
      JSON.parse(req.body)["additional_amount"] == 11
    end
  end

  # An extend is an increment, so the server needs a key to fold a retried one
  # back into a single grant. The manager supplies one; a caller that does not
  # still gets a key rather than an unguarded increment.
  def test_extend_mints_a_key_when_the_caller_omits_one
    keys = []
    record_idempotency_keys(
      stub_request(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend"), keys
    ).to_return(status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" })

    2.times do
      @wire.extend(lease_id: "lse_1", additional_amount: 500, expires_at: Time.utc(2026, 1, 1, 0, 5))
    end

    assert_equal 2, keys.size
    keys.each { |key| assert_match UUID_SHAPE, key }
    refute_equal keys[0], keys[1], "a separate extend must not reuse the previous call's key"
  end

  # The key is minted outside the client's retry loop, so a 500 that the client
  # retries carries the same key and the server grants the tranche once.
  def test_one_key_rides_every_attempt_of_a_single_extend
    keys = []
    record_idempotency_keys(
      stub_request(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/extend"), keys
    ).to_return(
      { status: 500, body: JSON.generate({ "error" => "boom" }), headers: { "Content-Type" => "application/json" } },
      { status: 200, body: JSON.generate(LEASE_BODY), headers: { "Content-Type" => "application/json" } }
    )

    grant = @wire.extend(lease_id: "lse_1", additional_amount: 500, expires_at: Time.utc(2026, 1, 1, 0, 5))

    assert_equal "lse_1", grant.lease_id
    assert_equal 2, keys.size
    assert_equal keys[0], keys[1]
  end
end

class CheckFlowTest < Minitest::Test
  include CreditTestHelpers

  CREDIT_ENTITLEMENT = {
    "value_type" => "credit", "credit_id" => "ct_1", "consumption_rate" => 10,
    "event_subtype" => "inference_tokens"
  }.freeze

  def setup
    @wire = LeaseSupport::ScriptedWireClient.new(clock)
    @leases = Leases::LeaseStore.new(clock: clock.to_proc)
    @reservations = Leases::ReservationStore.new(@leases, 1000, clock: clock.to_proc)
    @manager = Leases::LeaseManager.new(
      wire_client: @wire, lease_store: @leases, logger: silent_logger,
      config: { default_lease_size: 1000, default_reservation_ttl: 60_000 }, clock: clock.to_proc
    )
    @events = []
  end

  def teardown
    @reservations.stop
    @manager.stop
  end

  def run_check(results, usage: 10, event_subtype: "inference_tokens", on_acquire_failure: nil,
                balances: { "ct_1" => 5000 }, reservations: @reservations)
    datastream = LeaseSupport::ScriptedDataStream.new(
      flag_key: "inference", company: { id: "co_1", credit_balances: balances }, results: results
    )
    @datastream = datastream
    @fell_back = false
    Leases.check_with_lease(
      Leases::CheckDeps.new(
        lease_store: @leases, reservations: reservations, manager: @manager, datastream: datastream,
        logger: silent_logger, clock: clock.to_proc,
        enqueue_flag_check_event: ->(body) { @events << body }
      ),
      "inference", { company: { "id" => "co_1" } },
      { usage: usage, event_subtype: event_subtype, on_acquire_failure: on_acquire_failure }
    ) do
      @fell_back = true
      Leases::CheckResult.new(allowed: true, value: true, reason: "fallback", flag_key: "inference")
    end
  end

  def probe(entitlement = CREDIT_ENTITLEMENT)
    { "value" => true, "reason" => "probe", "entitlement" => entitlement }
  end

  # The WASM engine hands back camelCase keys, which a caller must not have to
  # read differently from the server-mode model.
  def test_the_engine_entitlement_is_normalized_to_snake_case
    entitlement = CREDIT_ENTITLEMENT.merge("metric_reset_at" => "2026-02-01T00:00:00Z")
    @leases.replace(lease_entry)
    result = run_check([probe(entitlement),
                        { "value" => true, "reason" => "ok", "entitlement" => entitlement }])

    assert_predicate result, :allowed?
    assert_equal "inference", result.entitlement[:feature_key]
    assert_equal "credit", result.entitlement[:value_type]
    assert_in_delta 10, result.entitlement[:consumption_rate]
    assert_equal Time.utc(2026, 2, 1), result.entitlement[:metric_reset_at]
  end

  # Every branch tests for :fail_closed, so a typo would quietly read as
  # fail-open and turn a gate permissive.
  def test_a_misspelled_failure_mode_fails_closed_and_says_so
    logger = RecordingLogger.new
    @wire.queue_acquire({ "error" => "wire down" })
    datastream = LeaseSupport::ScriptedDataStream.new(
      flag_key: "inference", company: { id: "co_1", credit_balances: { "ct_1" => 5000 } },
      results: [probe, { "value" => true, "reason" => "ok" }]
    )
    result = Leases.check_with_lease(
      Leases::CheckDeps.new(
        lease_store: @leases, reservations: @reservations, manager: @manager, datastream: datastream,
        logger: logger, clock: clock.to_proc, enqueue_flag_check_event: ->(body) { @events << body }
      ),
      "inference", { company: { "id" => "co_1" } },
      { usage: 10, event_subtype: "inference_tokens", on_acquire_failure: :fail_closd }
    ) { Leases::CheckResult.new(allowed: true, value: true, reason: "fallback", flag_key: "inference") }

    refute_predicate result, :allowed?
    assert(logger.warnings.any? { |w| w.include?("fail_closd") })
  end

  # A fraction of an event is not something the server bills, so the hold is
  # sized in whole event units. The reservation still records what the caller
  # declared.
  def test_a_fractional_usage_rounds_the_hold_up_to_a_whole_unit
    @leases.replace(lease_entry)
    result = run_check([probe, { "value" => true, "reason" => "ok" }], usage: 0.5)

    assert_predicate result, :allowed?
    assert_in_delta 10, result.reservation.credits_reserved
    assert_in_delta 0.5, result.reservation.quantity_reserved
    assert_in_delta 990, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # A boolean or override grant resolves without drawing a credit, so it must
  # not cost a lease acquire and a reserve-then-cancel.
  def test_a_non_credit_entitlement_falls_back_without_touching_the_wire
    @leases.replace(lease_entry)
    result = run_check([probe({ "value_type" => "boolean" })])

    assert @fell_back
    assert_nil result.reservation
    assert_empty @wire.acquire_calls
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  def test_an_incomplete_credit_entitlement_falls_back
    @leases.replace(lease_entry)
    run_check([probe({ "value_type" => "credit", "credit_id" => "ct_1", "consumption_rate" => 0 })])

    assert @fell_back
  end

  # The reservation is pinned to the lease try_reserve charged, not the one the
  # acquire handed back, so the settle refund names the lease actually debited.
  def test_the_reservation_pins_the_charged_lease
    @leases.replace(lease_entry(lease_id: "lse_current"))
    result = run_check([probe, { "value" => true, "reason" => "ok" }])

    assert_predicate result, :allowed?
    assert_equal "lse_current", result.reservation.lease_id
  end

  # A lease-path check resolves itself, so it has to enqueue the flag_check
  # event the plain paths would have.
  def test_a_lease_path_check_reports_a_flag_check_event
    @leases.replace(lease_entry)
    run_check([probe, { "value" => true, "reason" => "ok" }])

    assert_equal 1, @events.size
    assert_equal "inference", @events.first[:flag_key]
    assert @events.first[:value]
  end

  def test_a_fallback_exit_reports_no_flag_check_event
    @leases.replace(lease_entry)
    run_check([probe({ "value_type" => "boolean" })])

    assert_empty @events
  end

  # Fail-open is not a blanket allow: the engine still runs, so a company that
  # is not entitled stays denied with the lease backend down.
  def test_fail_open_still_denies_an_unentitled_company
    @wire.queue_acquire({ "error" => "wire down" })
    result = run_check([probe, { "value" => false, "reason" => "not_entitled" }], on_acquire_failure: :fail_open)

    refute_predicate result, :allowed?
    assert_equal "lease_acquire_failed", result.error
  end

  def test_fail_open_accepts_the_hyphenated_spelling
    @wire.queue_acquire({ "error" => "wire down" })
    result = run_check([probe, { "value" => true, "reason" => "evaluated" }], on_acquire_failure: "fail-open")

    assert_predicate result, :allowed?
  end

  # An engine that is itself down leaves no evaluation to fail open with.
  def test_an_engine_failure_during_the_gate_cancels_the_hold
    @leases.replace(lease_entry)
    datastream = LeaseSupport::ScriptedDataStream.new(
      flag_key: "inference", company: { id: "co_1", credit_balances: { "ct_1" => 5000 } },
      results: [probe]
    )
    result = Leases.check_with_lease(
      Leases::CheckDeps.new(
        lease_store: @leases, reservations: @reservations, manager: @manager, datastream: datastream,
        logger: silent_logger, clock: clock.to_proc, enqueue_flag_check_event: ->(body) { @events << body }
      ),
      "inference", { company: { "id" => "co_1" } },
      { usage: 10, event_subtype: "inference_tokens" }
    ) { Leases::CheckResult.new(allowed: true, value: true, reason: "fallback", flag_key: "inference") }

    refute_predicate result, :allowed?
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
    assert_equal 0, @reservations.size
  end

  # A store that cannot record the hold must not leave the debit stranded.
  def test_a_failed_reservation_persist_undoes_the_debit
    @leases.replace(lease_entry)
    failing = Object.new
    def failing.add(_reservation) = raise("redis down")
    def failing.consume(_id, _credits) = nil

    result = run_check([probe, { "value" => true, "reason" => "ok" }], reservations: failing)

    refute_predicate result, :allowed?
    assert_equal "lease_store_error", result.error
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # A NaN debit would slip through every comparison and poison a possibly shared
  # lease balance into approving everything.
  def test_a_nan_usage_never_reaches_the_store
    @leases.replace(lease_entry)
    result = run_check([], usage: Float::NAN)

    refute_predicate result, :allowed?
    assert_equal "invalid_usage", result.error
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  def test_zero_usage_falls_back_without_issuing_a_handle
    @leases.replace(lease_entry)
    result = run_check([], usage: 0)

    assert @fell_back
    assert_nil result.reservation
  end
end

class TrackSettleTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @leases = Leases::LeaseStore.new(clock: clock.to_proc)
    @leases.replace(lease_entry)
    @reservations = Leases::ReservationStore.new(@leases, 1000, clock: clock.to_proc)
  end

  def teardown
    @reservations.stop
  end

  def test_a_client_mode_settle_routes_through_the_lease_sub_ledger
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    outcome = Leases.consume_reservation_and_build_event(@reservations, reservation, 4)

    assert outcome.settled_locally
    assert_equal "lse_1", outcome.track[:lease_id]
    assert_nil outcome.track[:reservation_id]
    assert_in_delta 4, outcome.track[:quantity]
    assert_in_delta 960, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # The server prefers a lease id when both are set, and a server-mode hold has
  # no lease for it to route through.
  def test_a_server_mode_settle_names_the_reservation_and_not_a_lease
    body = Leases.build_reservation_track_event(reservation(mode: :server), 4)

    assert_equal "res_1", body[:reservation_id]
    assert_nil body[:lease_id]
  end

  # The event's quantity is an integer on the wire, so a partial unit bills as a
  # whole one, and the debit rounds up with it: the local ledger moves by
  # exactly what the event costs.
  def test_a_fractional_settle_bills_and_debits_whole_units
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    outcome = Leases.consume_reservation_and_build_event(@reservations, reservation, 1.2)

    assert_equal 2, outcome.track[:quantity]
    assert_in_delta 980, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # A quantity a hair above a whole unit bills as that unit, so the debit has to
  # shave the same float noise. A bare ceil would debit for 4 and bill for 3.
  def test_float_noise_debits_and_bills_the_same_whole_units
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    outcome = Leases.consume_reservation_and_build_event(@reservations, reservation, (0.1 + 0.2) * 10)

    assert_equal 3, outcome.track[:quantity]
    assert_in_delta 970, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  # A hold swept at its TTL still has to bill: the event is built from the
  # caller-held handle, not the store.
  def test_a_settle_after_the_sweep_still_bills_as_a_recovery_emit
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation(expires_at_ms: 10_000))
    clock.advance_ms(60_000)
    @reservations.sweep_expired

    outcome = Leases.consume_reservation_and_build_event(@reservations, reservation, 4)

    refute outcome.settled_locally
    assert_equal "inference_tokens", outcome.track[:event]
    assert_in_delta 1000, @leases.get("co_1", "ct_1").local_remaining_credits
  end

  def test_the_event_carries_the_evaluation_context_and_caller_traits
    body = Leases.build_reservation_track_event(reservation, 4, traits: { "model" => "sonnet" })

    assert_equal({ "id" => "co_1" }, body[:company])
    assert_equal({ "model" => "sonnet" }, body[:traits])
  end
end

class ServerCheckTest < Minitest::Test
  include CreditTestHelpers

  RESERVATION_BODY = {
    "id" => "res_1", "company_id" => "co_1", "credit_type_id" => "ct_1", "consumption_rate" => 10,
    "credits_reserved" => 100, "quantity_reserved" => 10, "event_subtype" => "inference_tokens",
    "expires_at" => "2026-01-01T00:01:00Z"
  }.freeze

  def setup
    @client = Schematic::Client.new(api_key: "sch_test", base_url: "https://api.schematichq.test")
    @deps = Leases::ServerCheckDeps.new(
      features: @client.features, credits: @client.credits, logger: silent_logger,
      reservation_ttl_ms: 60_000, default_value: -> { false }, clock: clock.to_proc
    )
  end

  def stub_check_and_reserve(status: 200, body: nil)
    stub_request(:post, "https://api.schematichq.test/flags/inference/check-and-reserve")
      .to_return(status: status, body: JSON.generate(body), headers: { "Content-Type" => "application/json" })
  end

  def run_server_check(options = {})
    Leases.check_with_server_reservation(
      @deps, "inference", { company: { "id" => "co_1" } },
      { usage: 10, event_subtype: "inference_tokens" }.merge(options)
    ) { Leases::CheckResult.new(allowed: true, value: true, reason: "fallback", flag_key: "inference") }
  end

  def test_a_granted_hold_becomes_a_server_mode_handle
    stub_check_and_reserve(body: { "data" => { "flag" => "inference", "value" => true,
                                               "reason" => "ok", "reservation" => RESERVATION_BODY } })

    result = run_server_check

    assert_predicate result, :allowed?
    assert_equal :server, result.reservation.mode
    assert_equal "res_1", result.reservation.lease_id
    assert_requested(:post, "https://api.schematichq.test/flags/inference/check-and-reserve") do |req|
      body = JSON.parse(req.body)
      body["quantity"] == 10 && body["expires_at"] == "2026-01-01T00:01:00Z" &&
        body.dig("preflight", "event_usage", "quantity") == 10
    end
  end

  def test_a_denied_check_returns_no_handle
    stub_check_and_reserve(body: { "data" => { "flag" => "inference", "value" => false,
                                               "reason" => "Insufficient credits" } })

    result = run_server_check

    refute_predicate result, :allowed?
    assert_nil result.reservation
  end

  # A 402 is the server's definitive answer, not a can't-gate, so it denies even
  # under fail-open: failing open would hand out credit the balance cannot cover.
  def test_a_402_denies_even_when_configured_to_fail_open
    stub_check_and_reserve(status: 402, body: { "error" => "insufficient credits" })

    result = run_server_check(on_acquire_failure: :fail_open)

    refute_predicate result, :allowed?
    assert_equal Leases::INSUFFICIENT_CREDITS_REASON, result.reason
  end

  # Server mode has no local engine to re-run, so fail-open returns the caller's
  # default.
  def test_fail_open_returns_the_caller_default_when_the_call_fails
    stub_check_and_reserve(status: 500, body: { "error" => "boom" })
    @deps.default_value = -> { true }

    result = run_server_check(on_acquire_failure: :fail_open)

    assert_predicate result, :allowed?
    assert_equal "server_reservation_failed", result.error
  end

  def test_fail_closed_denies_when_the_call_fails
    stub_check_and_reserve(status: 500, body: { "error" => "boom" })

    result = run_server_check

    refute_predicate result, :allowed?
    assert_equal "server_reservation_failed", result.error
  end

  # A hold with no subtype could never be settled, so it is released now rather
  # than parking credits until its TTL.
  def test_a_hold_with_no_event_subtype_is_released
    stub_check_and_reserve(body: { "data" => { "flag" => "inference", "value" => true, "reason" => "ok",
                                               "reservation" => RESERVATION_BODY.merge("event_subtype" => nil) } })
    release = stub_request(:put, "https://api.schematichq.test/billing/credits/reservations/res_1/release")
              .to_return(status: 200, body: "{}", headers: { "Content-Type" => "application/json" })

    result = run_server_check(event_subtype: nil)

    refute_predicate result, :allowed?
    assert_equal "missing_event_subtype", result.error
    assert_requested release
  end

  # The request body's quantity is an integer, so a fractional usage would
  # truncate and the server would size the hold below the work about to run.
  def test_a_fractional_usage_rounds_up_on_the_wire
    stub_check_and_reserve(body: { "data" => { "flag" => "inference", "value" => true,
                                               "reason" => "ok", "reservation" => RESERVATION_BODY } })

    run_server_check(usage: 1.5)

    assert_requested(:post, "https://api.schematichq.test/flags/inference/check-and-reserve") do |req|
      body = JSON.parse(req.body)
      body["quantity"] == 2 && body.dig("preflight", "event_usage", "quantity") == 2
    end
  end

  # Server mode gets its entitlement as a generated model and client mode as a
  # camelCase engine hash. A caller reading result.entitlement must not need to
  # know which one answered.
  def test_the_entitlement_is_normalized_to_one_shape
    stub_check_and_reserve(
      body: { "data" => { "flag" => "inference", "value" => true, "reason" => "ok",
                          "reservation" => RESERVATION_BODY,
                          "entitlement" => { "feature_id" => "feat_1", "feature_key" => "inference",
                                             "value_type" => "credit", "credit_id" => "ct_1",
                                             "consumption_rate" => 10,
                                             "metric_reset_at" => "2026-02-01T00:00:00Z" } } }
    )

    result = run_server_check

    assert_instance_of Hash, result.entitlement
    assert_equal "inference", result.entitlement[:feature_key]
    assert_equal "credit", result.entitlement[:value_type]
    assert_equal Time.utc(2026, 2, 1), result.entitlement[:metric_reset_at]
  end

  def test_a_misspelled_failure_mode_fails_closed_and_says_so
    logger = RecordingLogger.new
    @deps.logger = logger
    stub_check_and_reserve(status: 500, body: { "error" => "boom" })
    @deps.default_value = -> { true }

    result = run_server_check(on_acquire_failure: "fail-opne")

    refute_predicate result, :allowed?
    assert(logger.warnings.any? { |w| w.include?("fail-opne") })
  end

  def test_each_check_sends_its_own_idempotency_key
    keys = []
    record_idempotency_keys(
      stub_request(:post, "https://api.schematichq.test/flags/inference/check-and-reserve"), keys
    ).to_return(
      status: 200,
      body: JSON.generate({ "data" => { "flag" => "inference", "value" => true, "reason" => "ok",
                                        "reservation" => RESERVATION_BODY } }),
      headers: { "Content-Type" => "application/json" }
    )

    2.times { run_server_check }

    assert_equal 2, keys.size
    keys.each { |key| assert_match UUID_SHAPE, key }
    refute_equal keys[0], keys[1], "a separate check must not reuse the previous call's key"
  end

  # check-and-reserve takes a hold, so a 500 the client retries would otherwise
  # take a second one. The key is minted per check, not per attempt, so the
  # server hands back the hold it already took and the check still resolves.
  def test_a_retried_check_keeps_one_key_and_still_yields_the_hold
    keys = []
    record_idempotency_keys(
      stub_request(:post, "https://api.schematichq.test/flags/inference/check-and-reserve"), keys
    ).to_return(
      { status: 500, body: JSON.generate({ "error" => "boom" }), headers: { "Content-Type" => "application/json" } },
      { status: 200,
        body: JSON.generate({ "data" => { "flag" => "inference", "value" => true, "reason" => "ok",
                                          "reservation" => RESERVATION_BODY } }),
        headers: { "Content-Type" => "application/json" } }
    )

    result = run_server_check

    assert_predicate result, :allowed?
    assert_equal "res_1", result.reservation.id
    assert_equal 2, keys.size
    assert_equal keys[0], keys[1]
  end
end

class CreditLeaseClientWiringTest < Minitest::Test
  include CreditTestHelpers

  def build_client(credit_leases:, **)
    Schematic::SchematicClient.new(
      api_key: "sch_test", base_url: "https://api.schematichq.test",
      credit_leases: credit_leases, logger: silent_logger, **
    )
  end

  # Without DataStream, auto resolves to server mode rather than dropping every
  # check to a plain, ungated flag check.
  def test_auto_without_datastream_resolves_to_server_mode
    client = build_client(credit_leases: { default_reservation_ttl: 60_000 })

    assert_equal :server, client.send(:effective_lease_mode)
    assert_nil client.instance_variable_get(:@lease_store)
  ensure
    client&.close
  end

  # A DataStream whose start fails after construction clears the client, so auto
  # has to be resolved per check or every check would drop to a plain, ungated
  # flag check.
  def test_auto_resolves_per_check_and_falls_to_server_when_the_datastream_goes_away
    client = build_client(credit_leases: { mode: :auto })
    client.instance_variable_set(:@datastream_client, Object.new)
    %i[@credit_lease_manager @lease_store @reservations].each do |ivar|
      client.instance_variable_set(ivar, Object.new)
    end

    assert_equal :client, client.send(:effective_lease_mode)

    client.instance_variable_set(:@datastream_client, nil)

    assert_equal :server, client.send(:effective_lease_mode)
  ensure
    %i[@credit_lease_manager @lease_store @reservations].each do |ivar|
      client&.instance_variable_set(ivar, nil)
    end
    client&.close
  end

  # The API refuses a hold expiring more than an hour out, measured against its
  # own clock, so a server-mode TTL is clamped a step below the cap.
  def test_a_server_mode_reservation_ttl_is_clamped_below_the_api_cap
    client = build_client(credit_leases: { mode: :server, default_reservation_ttl: 2 * 60 * 60 * 1000 })

    assert_equal Leases::MAX_RESERVATION_TTL_MS - Leases::RESERVATION_TTL_SKEW_ALLOWANCE_MS,
                 client.instance_variable_get(:@server_reservation_ttl_ms)
  ensure
    client&.close
  end

  # In client mode the TTL sizes the local sweep, so clamping it would shorten
  # holds for no reason.
  def test_a_client_mode_reservation_ttl_is_left_alone
    client = build_client(credit_leases: { mode: :client, default_reservation_ttl: 2 * 60 * 60 * 1000 })

    assert_equal 2 * 60 * 60 * 1000, client.instance_variable_get(:@server_reservation_ttl_ms)
  ensure
    client&.close
  end

  # An existing Redis setup backs leases automatically, with no second client to
  # wire up.
  def test_lease_state_reuses_the_datastream_redis_client
    redis = LeaseSupport::FakeRedis.new(clock)
    client = build_client(
      credit_leases: { mode: :client }, use_data_stream: false,
      datastream_options: { redis_client: redis, redis_key_prefix: "acme:" }
    )

    assert_instance_of Leases::RedisLeaseStore, client.instance_variable_get(:@lease_store)
    assert client.instance_variable_get(:@lease_backend_shared)
  ensure
    client&.close
  end

  # A shared lease is one row per company and credit across every instance, so a
  # single process shutting down must not release it.
  def test_close_does_not_release_leases_held_in_a_shared_backend
    redis = LeaseSupport::FakeRedis.new(clock)
    client = build_client(
      credit_leases: { mode: :client }, datastream_options: { redis_client: redis }
    )
    store = client.instance_variable_get(:@lease_store)
    store.replace(lease_entry(expires_at_ms: 10 * 60 * 1000))
    released = stub_request(:put, %r{/billing/credits/lease/.*/release}).to_return(status: 200, body: "{}")

    client.close

    assert_not_requested released
  end

  def test_close_releases_leases_held_per_process
    client = build_client(credit_leases: { mode: :client })
    client.instance_variable_get(:@lease_store).replace(
      Leases::LeaseEntry.new(lease_id: "lse_1", company_id: "co_1", credit_type_id: "ct_1",
                             granted_amount: 1000, expires_at: Time.now + 600)
    )
    released = stub_request(:put, "https://api.schematichq.test/billing/credits/lease/lse_1/release")
               .to_return(status: 200, body: "{}", headers: { "Content-Type" => "application/json" })

    client.close

    assert_requested released
  end

  # A check with a usage that falls back to a plain check and then cannot reach
  # the API must answer with the caller's default, not the registered one.
  def test_a_fallback_check_that_fails_honors_the_caller_default
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger, flag_defaults: { "inference" => false })
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .to_return(status: 500, body: JSON.generate({ "error" => "boom" }),
                 headers: { "Content-Type" => "application/json" })

    result = client.check("inference", company: { "id" => "co_1" }, usage: 10, default_value: true)

    assert_predicate result, :allowed?
  ensure
    client&.close
  end

  # A callable default is resolved at check time, the same as on the credit
  # paths.
  def test_a_callable_default_is_resolved_on_the_fallback_path
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .to_return(status: 500, body: "{}", headers: { "Content-Type" => "application/json" })

    result = client.check("inference", company: { "id" => "co_1" }, usage: 10, default_value: -> { true })

    assert_predicate result, :allowed?
  ensure
    client&.close
  end

  # The cached metric is a local prediction of what the stream will push back,
  # so it belongs to an event that moved local state. A recovery emit dedupes
  # server-side, and bumping the metric for one would deny the caller's next
  # numeric-limit check until the stream corrected it.
  def test_a_settle_that_did_not_land_locally_leaves_the_cached_metric_alone
    client = build_client(credit_leases: { mode: :client })
    stub_request(:post, "https://c.schematichq.com/batch").to_return(status: 200, body: "")
    metrics = []
    datastream = Object.new
    datastream.define_singleton_method(:update_company_metrics) do |company, event, quantity|
      metrics << [company, event, quantity]
    end
    def datastream.connected? = true
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)
    leases = client.instance_variable_get(:@lease_store)
    leases.replace(lease_entry)
    leases.try_reserve("co_1", "ct_1", 100)

    # Never added to the store: swept at its TTL, or already settled.
    client.track_with_reservation(reservation, 4)

    assert_empty metrics

    client.instance_variable_get(:@reservations).add(reservation)
    client.track_with_reservation(reservation, 4)

    assert_equal [[{ "id" => "co_1" }, "inference_tokens", 4]], metrics
  ensure
    client&.close
  end

  # { "ct_1": {} } is the symbol :ct_1, and a caller who writes it means the
  # credit type, so both spellings have to reach the same slot, knobs included.
  def test_an_override_written_either_way_resolves_the_same_knobs
    [{ ct_1: { "default_lease_size" => 42 } }, { "ct_1" => { default_lease_size: 42 } }].each do |overrides|
      client = build_client(credit_leases: { mode: :server, overrides: overrides })

      resolved = Leases.resolve_config(client.instance_variable_get(:@credit_lease_config), "ct_1")

      assert_equal 42, resolved.lease_size
      client.close
    end
  end

  # A malformed usage is the caller asking to gate on a number that gates
  # nothing, so with gating configured it is refused by the failure mode rather
  # than quietly dropped, which would allow the call with no hold.
  def test_an_invalid_usage_is_denied_under_fail_closed
    client = build_client(credit_leases: { mode: :server })

    [-5, Float::NAN].each do |usage|
      result = client.check("inference", company: { "id" => "co_1" }, usage: usage,
                                         on_acquire_failure: :fail_closed)

      refute_predicate result, :allowed?
      assert_equal "invalid_usage", result.reason
      assert_nil result.reservation
    end
  ensure
    client&.close
  end

  # With no gating there is nothing to refuse: the value would only reach the
  # preflight, so the plain question still gets asked.
  def test_an_invalid_usage_without_credit_leases_asks_the_plain_question
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)
    body = nil
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .with { |req| body = JSON.parse(req.body) }
      .to_return(status: 200,
                 body: JSON.generate({ "data" => { "flag" => "inference", "value" => true, "reason" => "plan" } }),
                 headers: { "Content-Type" => "application/json" })
    stub_request(:post, "https://c.schematichq.com/batch").to_return(status: 200, body: "")

    result = client.check("inference", company: { "id" => "co_1" }, usage: -5)

    assert_predicate result, :allowed?
    refute body.key?("preflight")
  ensure
    client&.close
  end

  # An account is free to define an ordinary entity key called "id", so the
  # keys are looked up first and the cache's answer wins over the literal value.
  def test_a_plain_id_key_resolves_through_the_cache
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 0 })
    datastream = Object.new
    def datastream.get_cached_company(_company) = { "id" => "co_42" }
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    assert_equal "co_42", client.send(:resolve_company_id_with_wait, { "id" => "acme" })
  ensure
    client&.close
  end

  # Only once the key lookup comes up empty is a value read as the company's own
  # id, by its prefix rather than by the name of the key it sits under.
  def test_a_cache_miss_falls_back_to_a_prefixed_value_under_any_key
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 0 })
    datastream = Object.new
    def datastream.get_cached_company(_company) = nil
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    assert_equal "comp_9", client.send(:resolve_company_id_with_wait, { "account_id" => "comp_9" })
  ensure
    client&.close
  end

  def test_a_cache_miss_without_a_prefixed_value_resolves_to_nothing
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 0 })
    datastream = Object.new
    def datastream.get_cached_company(_company) = nil
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    assert_nil client.send(:resolve_company_id_with_wait, { "id" => "acme" })
  ensure
    client&.close
  end

  # Zero means cache-only, not "never resolve": a company the DataStream already
  # holds still prewarms, it is only the active fetch that is skipped.
  def test_a_zero_prewarm_timeout_still_resolves_from_the_cache
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 0 })
    datastream = Object.new
    def datastream.get_cached_company(_company) = { "id" => "co_1" }
    def datastream.get_company(_company) = raise("prewarm must not fetch at a zero timeout")
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    assert_equal "co_1", client.send(:resolve_company_id_with_wait, { "org_id" => "acme" })
  ensure
    client&.close
  end

  def test_a_zero_prewarm_timeout_never_fetches
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 0 })
    datastream = Object.new
    def datastream.get_cached_company(_company) = nil
    def datastream.get_company(_company) = raise("prewarm must not fetch at a zero timeout")
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    assert_nil client.send(:resolve_company_id_with_wait, { "org_id" => "acme" })
  ensure
    client&.close
  end

  # The generated transport takes its timeout from the client, not from a
  # request, so a per-check timeout is carried and not yet applied. This pins
  # the half this SDK owns: the request does carry it, in seconds, so it starts
  # working the moment the transport honors it.
  def test_a_per_check_timeout_is_carried_on_the_request_in_seconds
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)

    assert_empty client.send(:api_request_options, nil)
    assert_in_delta 1.5, client.send(:api_request_options, 1500)[:timeout_in_seconds]
    # And pins the half it does not: the generated transport never reads the
    # key. When a regeneration makes it read one, this fails, and the README
    # note saying the timeout is inert has to go with it.
    transport = File.read(File.expand_path("../lib/schematic/internal/http/raw_client.rb", __dir__))

    refute_includes transport.gsub(/^\s*#.*$/, ""), "timeout_in_seconds"
  ensure
    client&.close
  end

  # identify is a buffer push. Asking it to prewarm must not turn it into an
  # HTTP round trip on the caller's thread, which is what the flush is. The
  # ordering the prewarm poll depends on still holds, because the flush and the
  # poll run on the same background thread in that order.
  def test_identify_with_a_prewarm_does_not_flush_on_the_calling_thread
    client = build_client(credit_leases: { mode: :client })
    flushing = Queue.new
    release = Queue.new
    buffer = Object.new
    buffer.define_singleton_method(:push) { |_event| nil }
    buffer.define_singleton_method(:stop) { nil }
    buffer.define_singleton_method(:flush) do
      flushing << Thread.current
      release.pop
    end
    client.instance_variable_set(:@event_buffer, buffer)

    identifying = Thread.new do
      client.identify({ keys: { "user_id" => "u_1" }, company: { keys: { "id" => "co_1" } } },
                      prewarm: ["ct_1"])
    end

    # Joined with a bound rather than waited on: a flush back on the calling
    # thread would park here forever instead of failing.
    assert identifying.join(5), "identify blocked on the event buffer flush"
    refute_same identifying, flushing.pop
  ensure
    release << true
    client&.close
  end

  # A plain check over the API gates on the balance as it stands. A check with a
  # usage has to gate on the balance the action will leave behind, so the
  # preflight goes on the REST request too.
  def test_a_fallback_check_sends_the_preflight_on_the_rest_request
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference", "value" => true,
                                                                "reason" => "ok" } }),
                 headers: { "Content-Type" => "application/json" })

    client.check("inference", company: { "id" => "co_1" }, usage: 1.5, event_subtype: "inference_tokens")

    assert_requested(:post, "https://api.schematichq.test/flags/inference/check") do |req|
      preflight = JSON.parse(req.body)["preflight"]
      preflight["event_usage"]["event_subtype"] == "inference_tokens" &&
        preflight["event_usage"]["quantity"] == 2
    end
  end

  # A zero usage is documented as having no effect, so such a check is a plain
  # one. Sending an empty preflight would cost it the flag cache for nothing.
  def test_a_zero_usage_check_sends_no_preflight_and_stays_cacheable
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)
    plain = stub_request(:post, "https://api.schematichq.test/flags/inference/check")
            .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference", "value" => true,
                                                                      "reason" => "ok" } }),
                       headers: { "Content-Type" => "application/json" })

    client.check("inference", company: { "id" => "co_1" }, usage: 0)
    client.check("inference", company: { "id" => "co_1" }, usage: 0)

    # One request, so the second check was served from the cache the first
    # populated.
    assert_requested plain, times: 1
    assert_requested(:post, "https://api.schematichq.test/flags/inference/check") do |req|
      !JSON.parse(req.body).key?("preflight")
    end
  ensure
    client&.close
  end

  # The flag cache is keyed by flag, company and user, so a preflighted verdict
  # and a plain one would share an entry while answering different questions.
  def test_a_preflighted_check_neither_reads_nor_writes_the_flag_cache
    # The client builds its own local flag cache, which is what a plain check
    # populates.
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)
    plain = stub_request(:post, "https://api.schematichq.test/flags/inference/check")
            .with { |req| !JSON.parse(req.body).key?("preflight") }
            .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference", "value" => true,
                                                                      "reason" => "plain" } }),
                       headers: { "Content-Type" => "application/json" })
    preflighted = stub_request(:post, "https://api.schematichq.test/flags/inference/check")
                  .with { |req| JSON.parse(req.body).key?("preflight") }
                  .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference",
                                                                            "value" => false,
                                                                            "reason" => "preflighted" } }),
                             headers: { "Content-Type" => "application/json" })

    # A plain check caches its verdict.
    client.check_flag("inference", company: { "id" => "co_1" })
    client.check_flag("inference", company: { "id" => "co_1" })

    assert_requested plain, times: 1

    # The preflighted check goes to the API rather than reading that entry.
    result = client.check("inference", company: { "id" => "co_1" }, usage: 10)

    refute_predicate result, :allowed?
    assert_requested preflighted, times: 1

    # And leaves the cached plain verdict as it found it.
    assert client.check_flag("inference", company: { "id" => "co_1" })
    assert_requested plain, times: 1
  ensure
    client&.close
  end

  # Everything that is not :client or :server falls through to the auto
  # behaviour, so a typo would silently pick a mode the caller did not ask for.
  def test_a_misspelled_mode_falls_back_to_auto_and_says_so
    logger = RecordingLogger.new
    client = Schematic::SchematicClient.new(
      api_key: "sch_test", base_url: "https://api.schematichq.test", logger: logger,
      credit_leases: { mode: :serverr, default_reservation_ttl: 60_000 }
    )

    assert_equal :auto, client.instance_variable_get(:@credit_lease_mode)
    assert(logger.warnings.any? { |w| w.include?("serverr") })
  ensure
    client&.close
  end

  # Releases are synchronous round trips, so without a bound a slow API would
  # stretch close by one timeout per leased slot, right after the drain was
  # carefully bounded.
  def test_releasing_leases_on_close_stops_when_the_budget_runs_out
    logger = RecordingLogger.new
    store = Leases::LeaseStore.new(clock: clock.to_proc)
    10.times do |i|
      store.replace(Leases::LeaseEntry.new(lease_id: "lse_#{i}", company_id: "co_#{i}",
                                           credit_type_id: "ct_1", granted_amount: 1000,
                                           expires_at: Time.now + 600))
    end
    wire = Object.new
    released = []
    wire.define_singleton_method(:release) do |lease_id:, **|
      released << lease_id
      sleep 0.05
    end
    manager = Leases::LeaseManager.new(wire_client: wire, lease_store: store, logger: logger,
                                       clock: -> { Time.now })

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    manager.release_all_local_leases(150)
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    assert_operator elapsed_ms, :<, 500
    assert_operator released.size, :<, 10
    assert(logger.warnings.any? { |w| w.include?("left to server-side expiry") })
  end

  # The Java port had this as a blocker: a check with a usage but no leases
  # falls through to the REST check, and when that call cannot be made at all
  # the caller's default has to answer.
  def test_an_unreachable_api_answers_with_the_caller_default
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger, flag_defaults: { "inference" => false })
    stub_request(:post, "https://api.schematichq.test/flags/inference/check").to_timeout

    result = client.check("inference", company: { "id" => "co_1" }, usage: 10, default_value: true)

    assert_predicate result, :allowed?
  ensure
    client&.close
  end

  # A request sent over a closed socket is dropped without an error, so a fetch
  # would sit out the DataStream's own 30 second timeout, many times the
  # prewarm budget.
  def test_a_disconnected_datastream_resolves_within_the_budget
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 200 })
    datastream = Object.new
    def datastream.connected? = false
    def datastream.get_cached_company(_company) = nil
    def datastream.get_company(_company) = raise("a disconnected datastream must not be fetched from")
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result = client.send(:resolve_company_id_with_wait, { "org_id" => "acme" })
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    assert_nil result
    assert_operator elapsed_ms, :<, 600
  ensure
    client&.close
  end

  # And a connected but slow fetch is capped at the budget rather than the
  # DataStream's own timeout.
  def test_a_slow_connected_fetch_returns_at_the_deadline
    client = build_client(credit_leases: { mode: :client, prewarm_resolve_timeout_ms: 200 })
    datastream = Object.new
    def datastream.connected? = true
    def datastream.get_cached_company(_company) = nil

    def datastream.get_company(_company)
      sleep 30
      nil
    end

    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result = client.send(:resolve_company_id_with_wait, { "org_id" => "acme" })
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    assert_nil result
    assert_operator elapsed_ms, :<, 1000
  ensure
    client&.close
  end

  # A thread that would only log "no-op in server mode" is still a thread that
  # close has to wait out.
  def test_identify_with_a_prewarm_starts_no_thread_in_server_mode
    # close flushes the buffer this identify fills.
    stub_request(:post, %r{https://c\.schematichq\.com/.*}).to_return(status: 200, body: "{}")
    client = build_client(credit_leases: { mode: :server, default_reservation_ttl: 60_000 })

    client.identify({ keys: { "user_id" => "u_1" }, company: { keys: { "id" => "co_1" } } },
                    prewarm: ["ct_1"])

    assert_empty client.instance_variable_get(:@pending_prewarms)
  ensure
    client&.close
  end

  # Documented as never raising, and a caller reading ids out of config can hand
  # over nil without meaning to.
  def test_prewarm_tolerates_a_nil_credit_type_id_list
    client = build_client(credit_leases: { mode: :client })

    assert_nil client.prewarm(nil, company: { "id" => "co_1" })
    assert_nil client.prewarm([], company: { "id" => "co_1" })
  ensure
    client&.close
  end

  # A knob that cannot mean anything is a configuration bug, and the place to
  # say so is where the stack still points at the caller.
  def test_unusable_numeric_knobs_are_rejected_at_construction
    {
      { sweep_interval_ms: 0 } => "sweep_interval_ms",
      { default_reservation_ttl: -1 } => "default_reservation_ttl",
      { default_lease_duration: "5m" } => "default_lease_duration",
      { default_lease_size: 0 } => "default_lease_size",
      { low_water_mark: 1 } => "low_water_mark",
      { low_water_mark: 0 } => "low_water_mark",
      { low_water_mark: Float::NAN } => "low_water_mark",
      { low_water_mark: Float::INFINITY } => "low_water_mark",
      { sweep_interval_ms: Float::INFINITY } => "sweep_interval_ms",
      { default_reservation_ttl: Float::NAN } => "default_reservation_ttl",
      { overrides: { "ct_1" => { default_lease_size: -5 } } } => "default_lease_size"
    }.each do |knob, name|
      error = assert_raises(ArgumentError) { build_client(credit_leases: { mode: :client }.merge(knob)) }

      assert_includes error.message, name
    end
  end

  # The raise escapes the constructor, so the caller never gets a client to
  # close. Anything started before the check would run for the life of the
  # process with nothing holding a reference to stop it.
  def test_a_rejected_knob_leaves_no_thread_and_no_socket_behind
    before = Thread.list.select(&:alive?)
    sockets = []
    Schematic::DataStream::Client.define_singleton_method(:new) do |**|
      sockets << :opened
      raise "the socket must not be opened for a config that cannot be used"
    end

    assert_raises(ArgumentError) do
      build_client(credit_leases: { mode: :client, default_lease_size: -1 }, use_data_stream: true)
    end

    assert_empty sockets
    assert_empty(Thread.list.select(&:alive?) - before)
  ensure
    Schematic::DataStream::Client.singleton_class.send(:remove_method, :new)
  end

  # The lease paths guard usage; the plain one has to as well, because Ruby has
  # no type to stop a string reaching the preflight builder.
  def test_an_unusable_usage_is_warned_about_and_ignored
    logger = RecordingLogger.new
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: logger)
    plain = stub_request(:post, "https://api.schematichq.test/flags/inference/check")
            .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference", "value" => true,
                                                                      "reason" => "ok" } }),
                       headers: { "Content-Type" => "application/json" })

    ["3", -1, Float::NAN, Float::INFINITY].each do |usage|
      result = client.check("inference", company: { "id" => "co_1" }, usage: usage)

      assert_predicate result, :allowed?
    end

    assert_equal(4, logger.warnings.count { |w| w.include?("invalid usage") })
    # Each is an ordinary check: no preflight went out, so the first one's
    # verdict was cacheable and served the other three.
    assert_requested plain, times: 1
    assert_requested(:post, "https://api.schematichq.test/flags/inference/check") do |req|
      !JSON.parse(req.body).key?("preflight")
    end
  ensure
    client&.close
  end

  # identify never raises into its caller, and a caller can hand it any shape.
  def test_identify_with_a_prewarm_tolerates_a_malformed_company
    stub_request(:post, %r{https://c\.schematichq\.com/.*}).to_return(status: 200, body: "{}")
    client = build_client(credit_leases: { mode: :client })

    [{ keys: { "user_id" => "u_1" }, company: "acme" },
     { keys: { "user_id" => "u_1" } },
     { company: { keys: nil } }].each do |body|
      assert_nil client.identify(body, prewarm: ["ct_1"])
    end
  ensure
    client&.close
  end

  # A DataStream request over a closed socket is dropped without an error, so
  # waiting on it burns the 30 second resource timeout on a check that was
  # always going to fall back.
  def test_a_lease_check_against_a_disconnected_datastream_falls_back_at_once
    client = build_client(credit_leases: { mode: :client }, flag_defaults: { "inference" => false })
    datastream = Schematic::DataStream::Client.new(
      api_key: "sch_test", base_url: "wss://api.schematichq.test", logger: silent_logger, rules_engine: nil
    )
    # Never started, so the socket is down. The flag is cached; the company is
    # not, which is the pair that used to wait.
    refute_predicate datastream, :connected?
    datastream.instance_variable_get(:@flag_cache).set(
      datastream.send(:flag_cache_key, "inference"), { id: "flag_1", key: "inference" }
    )
    client.instance_variable_set(:@datastream_client, datastream)
    stub_request(:post, "https://c.schematichq.com/batch").to_return(status: 200, body: "")
    flag_check = stub_request(:post, "https://api.schematichq.test/flags/inference/check")
                 .to_return(status: 200,
                            body: JSON.generate({ "data" => { "flag" => "inference", "value" => true, "reason" => "plan" } }),
                            headers: { "Content-Type" => "application/json" })

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result = client.check("inference", company: { "org_id" => "acme" }, usage: 10, default_value: false)
    elapsed_ms = (Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000

    # Resolved as the plain fallback, not the 30 second resource timeout, and
    # nothing was held, so there is nothing to refund.
    assert_requested flag_check
    assert_predicate result, :allowed?
    assert_nil result.reservation
    assert_operator elapsed_ms, :<, 1000
  ensure
    client&.close
  end

  # A 200 whose value is nil is the API declining to answer, not a false.
  def test_a_nil_value_from_the_api_falls_back_to_the_default
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger, flag_defaults: { "inference" => false })
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .to_return(status: 200,
                 body: JSON.generate({ "data" => { "flag" => "inference", "value" => nil, "reason" => "ok" } }),
                 headers: { "Content-Type" => "application/json" })
    stub_request(:post, "https://c.schematichq.com/batch").to_return(status: 200, body: "")

    result = client.check("inference", company: { "id" => "co_1" }, usage: 10, default_value: true)

    assert_predicate result, :allowed?
    assert_equal "flag default", result.reason
  ensure
    client&.close
  end

  # Same on the DataStream path, where the registered flag default stands in.
  def test_a_nil_value_from_the_datastream_falls_back_to_the_flag_default
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger, flag_defaults: { "inference" => true })
    datastream = Object.new
    def datastream.connected? = true
    def datastream.check_flag(_eval_ctx, flag_key) = { value: nil, reason: "no rules", flag_key: flag_key }
    def datastream.close = nil
    client.instance_variable_set(:@datastream_client, datastream)
    stub_request(:post, "https://c.schematichq.com/batch").to_return(status: 200, body: "")

    response = client.check_flag_with_entitlement("inference", company: { "id" => "co_1" })

    assert response.value
  ensure
    client&.close
  end

  def test_prewarm_is_a_no_op_without_credit_leases
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger)

    assert_nil client.prewarm(["ct_1"], company: { "id" => "co_1" })
  ensure
    client&.close
  end

  # Without credit_leases, check is a plain flag check with no gating.
  def test_check_without_credit_leases_falls_through_to_a_plain_check
    client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                            logger: silent_logger, flag_defaults: { "inference" => true })
    stub_request(:post, "https://api.schematichq.test/flags/inference/check")
      .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "inference", "value" => true,
                                                                "reason" => "ok" } }),
                 headers: { "Content-Type" => "application/json" })

    result = client.check("inference", company: { "id" => "co_1" }, usage: 10)

    assert_predicate result, :allowed?
    assert_nil result.reservation
  ensure
    client&.close
  end
end
