# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "webmock/minitest"
WebMock.disable_net_connect!(allow_localhost: true)
require_relative "../lib/schematichq"

# The event_quantities preflight and the quantity_rates it prices from, run
# through the WASM engine with the snake_case payloads DataStream sends.
module EventQuantitiesHelpers
  SUBTYPE = "chat"
  CREDIT_ID = "credit-abc"

  # A single credit-balance rule priced like an inference entitlement: requests
  # at consumption_rate, tokens at their own rates.
  def inference_flag(consumption_rate, quantity_rates = nil)
    condition = {
      "id" => "cond-1", "account_id" => "acc_1", "environment_id" => "env_1",
      "condition_type" => "credit", "operator" => "lt", "resource_ids" => [], "trait_value" => "",
      "credit_id" => CREDIT_ID, "consumption_rate" => consumption_rate, "event_subtype" => SUBTYPE
    }
    condition["quantity_rates"] = quantity_rates if quantity_rates
    {
      "id" => "flag1", "key" => "chat", "account_id" => "acc_1", "environment_id" => "env_1",
      "default_value" => false,
      "rules" => [{
        "id" => "rule-1", "account_id" => "acc_1", "environment_id" => "env_1", "name" => "Credits",
        "rule_type" => "plan_entitlement", "priority" => 0, "value" => true,
        "conditions" => [condition], "condition_groups" => []
      }]
    }
  end

  def company_with_balance(balance, extra = {})
    {
      "id" => "co_1", "account_id" => "acc_1", "environment_id" => "env_1", "keys" => { "id" => "co_1" },
      "credit_balances" => { CREDIT_ID => balance }, "metrics" => [], "traits" => [], "rules" => []
    }.merge(extra)
  end

  def engine
    @engine ||= Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error)).tap(&:initialize!)
  end

  def require_engine
    # The wasm binary is fetched via scripts/download-wasm.sh and may be absent
    # (or the wasmtime gem missing) in some environments; skip rather than fail.
    skip "WASM rules engine unavailable (wasm binary or wasmtime gem missing)" unless engine.initialized?
  end
end

class EventQuantitiesTest < Minitest::Test
  include EventQuantitiesHelpers

  RATES = { "input_tokens" => 0.001, "output_tokens" => 0.01 }.freeze
  # 1 request x 0.5 + (1000 - 400 cached) x 0.001 + 100 x 0.01 = 2.1. The cached
  # tokens are unrated, so they cost nothing but still come out of input.
  QUANTITIES = { "input_tokens" => 1000, "cached_input_tokens" => 400, "output_tokens" => 100 }.freeze
  CALL = { event_quantities: { event_subtype: SUBTYPE, quantities: QUANTITIES } }.freeze

  def setup
    require_engine
  end

  def check(balance, options)
    engine.check_flag_with_options(inference_flag(0.5, RATES), company_with_balance(balance), nil, options)
  end

  def test_passes_when_the_balance_covers_the_call
    result = check(2.1, CALL)

    assert_equal "rule-1", result[:rule_id]
    assert result[:value]
  end

  def test_refuses_when_the_balance_falls_short
    # Covers the request and the legacy single unit, not the tokens.
    result = check(2.0, CALL)

    assert_nil result[:rule_id]
    refute result[:value]
  end

  def test_ignored_for_another_subtype
    other = { event_quantities: { event_subtype: "other", quantities: { "input_tokens" => 1e6 } } }

    assert_equal "rule-1", check(1.0, other)[:rule_id]
  end

  def test_quantity_multiplies_the_base_not_the_quantities
    # 3 x 0.5 + 600 x 0.001 + 100 x 0.01 = 3.1.
    options = { event_quantities: { event_subtype: SUBTYPE, quantity: 3, quantities: QUANTITIES } }

    assert_equal "rule-1", check(3.1, options)[:rule_id]
    assert_nil check(3.0, options)[:rule_id]
  end

  def test_credit_cost_beats_event_quantities
    assert_equal "rule-1", check(1.0, CALL.merge(credit_cost: { CREDIT_ID => 1.0 }))[:rule_id]
  end

  def test_event_quantities_beats_event_usage
    # event_usage alone would ask 1 x 0.5, which 2.0 covers.
    assert_nil check(2.0, CALL.merge(event_usage: { event_subtype: SUBTYPE, quantity: 1 }))[:rule_id]
  end

  def test_fractional_quantities_pass_through_unrounded
    # 0.5 + 0.5 x 0.01 = 0.505; rounding the half token up would ask 0.51.
    options = { event_quantities: { event_subtype: SUBTYPE, quantities: { "output_tokens" => 0.5 } } }

    assert_equal "rule-1", check(0.505, options)[:rule_id]
  end

  def test_rejects_negative_values
    [
      { event_subtype: SUBTYPE, quantity: -1 },
      { event_subtype: SUBTYPE, quantities: { "input_tokens" => -1 } }
    ].each do |event_quantities|
      result = check(100, { event_quantities: event_quantities })

      refute result[:value]
      refute_nil result[:err]
    end
  end

  def test_a_company_entitlements_quantity_rates_reach_the_result
    flag = inference_flag(0.5)
    company = company_with_balance(0, "entitlements" => [{
      "feature_id" => "feat-1", "feature_key" => flag["key"],
      "value_type" => "credit", "quantity_rates" => RATES
    }])

    result = engine.check_flag(flag, company)

    assert_equal({ input_tokens: 0.001, output_tokens: 0.01 }, result[:entitlement][:quantityRates])
  end
end

# testdata/quantity_cost.json is copied verbatim from schematic-api's
# api/lib/rulesengine/testdata/quantity_cost.json. The API's burn and the engine
# both price every case there; running them through the WASM engine here pins
# that this SDK's wire shape for quantity_rates and event_quantities reaches
# that pricing intact.
class EventQuantitiesFixtureTest < Minitest::Test
  include EventQuantitiesHelpers

  FIXTURE = JSON.parse(File.read(File.join(__dir__, "testdata", "quantity_cost.json")))

  def setup
    require_engine
  end

  def test_every_case_prices_as_the_api_burns_it
    cases = FIXTURE["cases"].reject do |c|
      # The preflight rejects negative quantities before pricing.
      c.fetch("quantity", 0).negative? || c.fetch("quantities", {}).values.any?(&:negative?)
    end

    refute_empty cases

    cases.each do |tc|
      flag = inference_flag(tc["consumption_rate"], tc["quantity_rates"])
      event = { event_subtype: SUBTYPE, quantity: tc["quantity"], quantities: tc["quantities"] }.compact
      options = { event_quantities: event }
      cost = tc["expected_cost"]

      # A cost priced to zero gates on balance > 0, so the smallest positive
      # balance passes and zero does not.
      covers = (cost * (1 + 1e-9)) + 1e-9
      short = cost.zero? ? 0 : cost * (1 - 1e-6)

      assert_equal "rule-1", engine.check_flag_with_options(flag, company_with_balance(covers), nil, options)[:rule_id],
                   "#{tc["name"]}: balance #{covers} should cover cost #{cost}"
      assert_nil engine.check_flag_with_options(flag, company_with_balance(short), nil, options)[:rule_id],
                 "#{tc["name"]}: balance #{short} should not cover cost #{cost}"
    end
  end
end

# The REST preflight body has no event_quantities yet, so a check that goes
# over the API leaves it off and says so.
class EventQuantitiesRestTest < Minitest::Test
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

  CHECK_URL = "https://api.schematichq.test/flags/chat/check"

  def setup
    @logger = RecordingLogger.new
    @client = Schematic::SchematicClient.new(api_key: "sch_test", base_url: "https://api.schematichq.test",
                                             logger: @logger)
    @stub = stub_request(:post, CHECK_URL)
            .to_return(status: 200, body: JSON.generate({ "data" => { "flag" => "chat", "value" => true,
                                                                      "reason" => "ok" } }),
                       headers: { "Content-Type" => "application/json" })
  end

  def teardown
    @client&.close
  end

  def event_quantities
    { event_subtype: "chat", quantities: { "input_tokens" => 1000 } }
  end

  def test_the_rest_of_the_preflight_still_goes_on_the_request
    @client.check_flag_with_entitlement("chat", company: { "id" => "co_1" },
                                                preflight: { usage: 5, event_quantities: event_quantities })

    assert_requested(:post, CHECK_URL) do |req|
      JSON.parse(req.body)["preflight"] == { "usage" => 5 }
    end
    assert(@logger.warnings.any? { |w| w.include?("event_quantities") })
  end

  # With nothing else in it, the preflight goes away and the check is a plain,
  # cacheable one.
  def test_a_preflight_of_only_event_quantities_is_a_plain_check
    2.times do
      @client.check_flag_with_entitlement("chat", company: { "id" => "co_1" },
                                                  preflight: { event_quantities: event_quantities })
    end

    assert_requested(:post, CHECK_URL, times: 1) { |req| !JSON.parse(req.body).key?("preflight") }
  end
end
