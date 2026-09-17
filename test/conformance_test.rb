# frozen_string_literal: true

require "minitest/autorun"
require "json"
require_relative "../lib/schematichq"
require_relative "lease_support"

# Runs the language-agnostic conformance vectors against this SDK.
#
# The vectors and the semantics they pin live in conformance/ at the repo root,
# copied verbatim from schematic-node (the reference implementation). This
# runner is the only language-specific piece; every port reimplements it and
# must pass the same vectors, against every store backend it ships.
class ConformanceTest < Minitest::Test
  Leases = Schematic::Credits::Leases

  VECTOR_DIR = File.expand_path("../conformance/vectors", __dir__)
  BACKENDS = %w[in_memory redis].freeze

  # One vector's stores, manager, clock, and reservation handles.
  class Harness
    attr_reader :clock, :leases, :reservations, :crash, :handles, :redis

    def initialize(backend, config)
      @config = config
      @clock = LeaseSupport::VirtualClock.new
      @handles = {}
      if backend == "redis"
        @redis = LeaseSupport::FakeRedis.new(@clock)
        @leases = Leases::RedisLeaseStore.new(client: @redis, clock: @clock.to_proc)
        @crash = LeaseSupport::CrashingRefund.new(@leases)
        @reservations = Leases::RedisReservationStore.new(client: @redis, lease_store: @crash,
                                                          clock: @clock.to_proc)
      else
        @leases = Leases::LeaseStore.new(clock: @clock.to_proc)
        @crash = LeaseSupport::CrashingRefund.new(@leases)
        @reservations = Leases::ReservationStore.new(@crash, Leases::DEFAULT_SWEEP_INTERVAL_MS,
                                                     clock: @clock.to_proc)
      end
    end

    # Built on first use so a pure store vector never spins one up.
    def wire
      @wire ||= LeaseSupport::ScriptedWireClient.new(@clock)
    end

    def manager
      @manager ||= Leases::LeaseManager.new(
        wire_client: wire,
        lease_store: @leases,
        logger: Schematic::ConsoleLogger.new(level: :error),
        config: @config,
        clock: @clock.to_proc
      )
    end

    def stop
      @reservations&.stop
      @manager&.stop
    end

    def reservation_id(step)
      handle = step["handle"]
      return @handles.fetch(handle).id if handle

      step.fetch("id")
    end
  end

  # Build one test method per (backend, category, vector) so a failure names the
  # vector it came from.
  Dir[File.join(VECTOR_DIR, "*.json")].each do |path|
    document = JSON.parse(File.read(path))
    category = document["category"]
    document["vectors"].each do |vector|
      BACKENDS.each do |backend|
        next if vector["backends"] && !vector["backends"].include?(backend)

        define_method("test_#{backend}_#{category}_#{vector["name"]}") do
          run_vector(backend, vector)
        end
      end
    end
  end

  private

  def run_vector(backend, vector)
    given = vector["given"] || {}
    harness = Harness.new(backend, config_from(given["config"]))
    (given["leases"] || []).each do |lease|
      wrote = harness.leases.replace(lease_from(harness, lease))

      assert wrote, "given.leases must install: #{lease["lease_id"]}"
    end
    (vector["operations"] || []).each { |step| run_operation(harness, step) }
  ensure
    harness&.stop
  end

  def config_from(config)
    config ||= {}
    {
      default_lease_duration: config["lease_duration_ms"],
      default_reservation_ttl: config["reservation_ttl_ms"],
      default_lease_size: config["lease_size"],
      low_water_mark: config["low_water_mark"]
    }.compact
  end

  def lease_from(harness, spec)
    Leases::LeaseEntry.new(
      lease_id: spec["lease_id"],
      company_id: spec["company_id"],
      credit_type_id: spec["credit_type_id"],
      granted_amount: spec["granted_amount"],
      expires_at: harness.clock.at_ms(spec["expires_at_ms"])
    )
  end

  def run_operation(harness, step)
    handler = "op_#{step["op"]}"
    raise "unknown conformance step: #{step["op"]}" unless respond_to?(handler, true)

    send(handler, harness, step, step["expect"] || {})
  end

  # --- store-level ops -------------------------------------------------------

  def op_advance_clock(harness, step, _expect)
    harness.clock.advance_ms(step["ms"])
  end

  def op_replace_lease(harness, step, expect)
    wrote = harness.leases.replace(lease_from(harness, step))
    assert_equal expect["written"], wrote if expect.key?("written")
  end

  def op_drop_lease(harness, step, _expect)
    harness.leases.drop(step["company_id"], step["credit_type_id"])
  end

  def op_try_reserve(harness, step, expect)
    result = harness.leases.try_reserve(step["company_id"], step["credit_type_id"], step["credits"])

    assert_nullable_number(expect, "balance", result&.balance)
    return unless expect.key?("lease_id")

    if expect["lease_id"].nil?
      assert_nil result
    else
      # The charged lease is what a caller pins its reservation to, so a vector
      # naming one is checking the pin, not just the arithmetic.
      assert_equal expect["lease_id"], result.lease_id
    end
  end

  def op_refund_lease(harness, step, _expect)
    harness.leases.refund(step["company_id"], step["credit_type_id"], step["credits"], step["pin_lease_id"])
  end

  def op_extend_lease(harness, step, _expect)
    expires_at = step["expires_at_ms"] ? harness.clock.at_ms(step["expires_at_ms"]) : nil
    harness.leases.extend(step["company_id"], step["credit_type_id"], step["granted_total"], expires_at,
                          step["pin_lease_id"])
  end

  def op_get_lease(harness, step, expect)
    entry = harness.leases.get(step["company_id"], step["credit_type_id"])
    assert_equal expect["exists"], !entry.nil? if expect.key?("exists")
    if expect.key?("lease_id")
      expect["lease_id"].nil? ? assert_nil(entry) : assert_equal(expect["lease_id"], entry.lease_id)
    end
    assert_in_delta expect["granted_amount"], entry.granted_amount if expect.key?("granted_amount")
    return unless expect.key?("local_remaining_credits")

    assert_in_delta expect["local_remaining_credits"], entry.local_remaining_credits
  end

  def op_add_reservation(harness, step, _expect)
    harness.reservations.add(Leases::Reservation.new(
      id: step["id"],
      lease_id: step["lease_id"],
      company_id: step["company_id"],
      credit_type_id: step["credit_type_id"],
      event_subtype: step["event_subtype"],
      quantity_reserved: step["quantity_reserved"],
      credits_reserved: step["credits_reserved"],
      consumption_rate: step["consumption_rate"],
      expires_at: harness.clock.at_ms(step["expires_at_ms"]),
      eval_ctx: { company: { id: step["company_id"] } }
    ))
  end

  def op_consume_reservation(harness, step, expect)
    id = harness.reservation_id(step)
    if step["crash_before_refund"]
      harness.crash.arm
      assert_raises(LeaseSupport::CrashingRefund::SimulatedCrash) do
        harness.reservations.consume(id, step["credits"])
      end
      assert expect["throws"]
      return
    end

    assert_nullable_number(expect, "consumed", harness.reservations.consume(id, step["credits"]))
  end

  def op_get_reservation(harness, step, expect)
    reservation = harness.reservations.get(harness.reservation_id(step))
    assert_equal expect["exists"], !reservation.nil? if expect.key?("exists")
  end

  def op_reserved_credits(harness, step, expect)
    total = harness.reservations.reserved_credits(step["company_id"], step["credit_type_id"])

    assert_in_delta expect["total"], total
  end

  def op_reservation_count(harness, _step, expect)
    assert_equal expect["count"], harness.reservations.size
  end

  def op_sweep_expired(harness, _step, expect)
    swept = harness.reservations.sweep_expired
    assert_equal expect["swept"], swept if expect.key?("swept")
  end

  # --- manager-level ops -----------------------------------------------------

  def op_acquire_if_needed(harness, step, expect)
    harness.wire.queue_acquire(step["server"]) if step["server"]
    if (install = step["install_during_wire"])
      harness.wire.during_acquire = -> { harness.leases.replace(lease_from(harness, install)) }
    end
    entry = harness.manager.acquire_if_needed(step["company_id"], step["credit_type_id"])
    harness.manager.drain

    if expect.key?("lease_id")
      expect["lease_id"].nil? ? assert_nil(entry) : assert_equal(expect["lease_id"], entry&.lease_id)
    end
    assert_equal expect["wire_acquires"], harness.wire.acquire_calls.size if expect.key?("wire_acquires")
    assert_in_delta expect["last_acquire_requested_amount"], harness.wire.acquire_calls.last.requested_amount if expect.key?("last_acquire_requested_amount")
    return unless expect.key?("released_lease_ids")

    assert_equal expect["released_lease_ids"], harness.wire.release_calls
  end

  def op_maybe_extend(harness, step, expect)
    harness.wire.queue_extend(step["server"]) if step["server"]
    harness.manager.maybe_extend_in_background(step["company_id"], step["credit_type_id"], step["required_credits"])
    harness.manager.drain

    assert_equal expect["wire_extends"], harness.wire.extend_calls.size if expect.key?("wire_extends")
    assert_in_delta expect["last_extend_additional_amount"], harness.wire.extend_calls.last.additional_amount if expect.key?("last_extend_additional_amount")
    return unless expect.key?("last_extend_lease_id")

    assert_equal expect["last_extend_lease_id"], harness.wire.extend_calls.last.lease_id
  end

  def op_release_all_local_leases(harness, _step, expect)
    harness.manager.release_all_local_leases
    assert_equal expect["released_lease_ids"], harness.wire.release_calls if expect.key?("released_lease_ids")
    return unless expect.key?("remaining_slots")

    assert_equal expect["remaining_slots"], harness.leases.list.size
  end

  # --- flow-level ops --------------------------------------------------------

  def op_check(harness, step, expect)
    flag_key = step["flag_key"] || "flag"
    spec = step["company"] || { "id" => "co_1" }
    if (script = step["server"])
      harness.wire.queue_acquire(script["acquire"]) if script["acquire"]
      harness.wire.queue_extend(script["extend"]) if script["extend"]
    end
    datastream = LeaseSupport::ScriptedDataStream.new(
      flag_key: flag_key,
      company: { id: spec["id"], credit_balances: symbolize_balances(spec["credit_balances"]) },
      results: step["engine"] || []
    )

    fell_back = false
    fallback = -> do
      fell_back = true
      Leases::CheckResult.new(allowed: true, value: true, reason: "fallback", flag_key: flag_key)
    end
    result = Leases.check_with_lease(
      Leases::CheckDeps.new(
        lease_store: harness.leases, reservations: harness.reservations, manager: harness.manager,
        datastream: datastream, logger: Schematic::ConsoleLogger.new(level: :error), clock: harness.clock.to_proc
      ),
      flag_key,
      { company: { id: spec["id"] } },
      { usage: step["usage"], event_subtype: step["event_subtype"],
        on_acquire_failure: step["on_acquire_failure"] },
      &fallback
    )
    harness.manager.drain

    assert_check_result(expect, result, fell_back)
    assert_engine_calls(step, expect, datastream.calls, spec)
    assert_equal expect["wire_extends"], harness.wire.extend_calls.size if expect.key?("wire_extends")
    assert_in_delta expect["last_extend_additional_amount"], harness.wire.extend_calls.last.additional_amount if expect.key?("last_extend_additional_amount")
    return unless step["save_reservation_as"] && result.reservation

    harness.handles[step["save_reservation_as"]] = result.reservation
  end

  def op_track(harness, step, expect)
    reservation = harness.handles.fetch(step["handle"])
    outcome = Leases.consume_reservation_and_build_event(harness.reservations, reservation, step["actual_quantity"])
    assert_equal expect["settled_locally"], outcome.settled_locally if expect.key?("settled_locally")
    return unless expect.key?("track")

    want = expect["track"]
    assert_equal want["event"], outcome.track[:event] if want.key?("event")
    assert_in_delta want["quantity"], outcome.track[:quantity] if want.key?("quantity")
    assert_equal want["lease_id"], outcome.track[:lease_id] if want.key?("lease_id")
  end

  def assert_check_result(expect, result, fell_back)
    assert_equal expect["allowed"], result.allowed if expect.key?("allowed")
    assert_equal expect["reason"], result.reason if expect.key?("reason")
    assert_equal expect["err"], result.error if expect.key?("err")
    assert_equal expect["has_reservation"], !result.reservation.nil? if expect.key?("has_reservation")
    assert_equal expect["fallback_called"], fell_back if expect.key?("fallback_called")
    return unless expect.key?("reservation")

    want = expect["reservation"]
    reservation = result.reservation

    refute_nil reservation
    assert_equal want["lease_id"], reservation.lease_id if want.key?("lease_id")
    assert_equal want["credit_type_id"], reservation.credit_type_id if want.key?("credit_type_id")
    assert_equal want["event_subtype"], reservation.event_subtype if want.key?("event_subtype")
    assert_in_delta want["quantity_reserved"], reservation.quantity_reserved if want.key?("quantity_reserved")
    assert_in_delta want["credits_reserved"], reservation.credits_reserved if want.key?("credits_reserved")
    assert_in_delta want["consumption_rate"], reservation.consumption_rate if want.key?("consumption_rate")
  end

  def assert_engine_calls(step, expect, calls, spec)
    return unless expect.key?("engine_calls")

    want = expect["engine_calls"]

    assert_equal want.size, calls.size
    credit_id = credit_id_from(step, spec)
    want.each_with_index do |expected, index|
      got = calls[index]
      if expected.key?("credit_balance")
        refute_empty credit_id.to_s, "engine_calls needs a credit id to assert a balance against"
        assert_in_delta expected_balance(expected["credit_balance"]), got.credit_balances[credit_id]
      end
      assert_in_delta expected["credit_cost"], got.options[:credit_cost][credit_id] if expected.key?("credit_cost")
      if expected.key?("event_usage")
        assert_equal expected["event_usage"]["event_subtype"], got.options[:event_usage][:event_subtype]
        assert_in_delta expected["event_usage"]["quantity"], got.options[:event_usage][:quantity]
      end
      assert_in_delta expected["usage"], got.options[:usage] if expected.key?("usage")
    end
  end

  # A balance expectation is a number, or the name of the effectively unlimited
  # figure the fail-open substitution uses.
  def expected_balance(raw)
    raw == "max_safe_integer" ? Leases::FAIL_OPEN_BALANCE : raw
  end

  # The credit a vector's balance and cost expectations are about: the one the
  # scripted entitlement meters, or the company's only balance when no
  # entitlement names one.
  def credit_id_from(step, spec)
    named = (step["engine"] || []).filter_map { |result| result.dig("entitlement", "credit_id") }.first
    named || (spec["credit_balances"] || {}).keys.first
  end

  def symbolize_balances(balances)
    (balances || {}).each_with_object({}) { |(id, value), out| out[id] = value }
  end

  # --- assertions ------------------------------------------------------------

  # Compare a result that may be the refused outcome, which the vectors write as
  # JSON null and never as a figure.
  def assert_nullable_number(expect, key, value)
    return unless expect.key?(key)

    if expect[key].nil?
      assert_nil value, "expected #{key} to be refused, got #{value}"
    else
      refute_nil value, "expected #{key} to be #{expect[key]}, got the refused result"
      assert_in_delta expect[key], value
    end
  end
end
