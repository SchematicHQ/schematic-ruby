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
end

class RedisStoreLayoutTest < Minitest::Test
  include CreditTestHelpers

  def setup
    @redis = LeaseSupport::FakeRedis.new(clock)
    @leases = Leases::RedisLeaseStore.new(client: @redis, key_prefix: "acme:", clock: clock.to_proc)
    @reservations = Leases::RedisReservationStore.new(client: @redis, lease_store: @leases, key_prefix: "acme:",
                                                      clock: clock.to_proc)
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

  # A track event's quantity is an integer on the wire, so a partial unit must
  # settle as a whole one. Truncating would bill a sub-unit settle as nothing.
  def test_a_fractional_settle_rounds_up_rather_than_truncating
    @leases.try_reserve("co_1", "ct_1", 100)
    @reservations.add(reservation)

    outcome = Leases.consume_reservation_and_build_event(@reservations, reservation, 1.2)

    assert_equal 2, outcome.track[:quantity]
    # The lease is debited against the billed quantity, not the raw one, so the
    # local view does not drift below what the server charges.
    assert_in_delta 980, @leases.get("co_1", "ct_1").local_remaining_credits
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
