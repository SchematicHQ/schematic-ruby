# frozen_string_literal: true

require_relative "test_helper"
require "minitest/autorun"

# Regression for SCHY-471.
#
# A company-override entitlement rule whose metric condition uses a
# calendar/billing metric period drives the engine into the metric-period-reset
# code path, which needs a wall clock. On the raw wasm32-unknown-unknown build
# that path used to trap (+wasm unreachable+); the flag then wrongly fell back to
# its default value for a company that is legitimately entitled. The host now
# injects the current time via +setCurrentTimeMillis+ so this evaluates cleanly.
class RulesEngineClockTest < Minitest::Test
  def setup
    @engine = Schematic::RulesEngine.new
    @engine.initialize!
    # The wasm binary is fetched via scripts/download-wasm.sh and may be absent
    # (or the wasmtime gem missing) in some environments — skip rather than fail.
    skip "WASM rules engine unavailable (wasm binary or wasmtime gem missing)" unless @engine.initialized?
  end

  def flag
    {
      "id" => "flag1", "key" => "mcp-access", "account_id" => "acc_1",
      "environment_id" => "env_1", "default_value" => false, "rules" => []
    }
  end

  # Usage 40 < allocation 100, so the override grants the feature.
  def entitled_company
    {
      "id" => "co_entitled", "account_id" => "acc_1", "environment_id" => "env_1",
      "keys" => { "id" => "co_entitled" },
      "metrics" => [{
        "account_id" => "acc_1", "environment_id" => "env_1", "company_id" => "co_entitled",
        "event_subtype" => "api-calls", "period" => "current_month",
        "month_reset" => "billing_cycle", "value" => 40, "created_at" => "2023-01-01T00:00:00Z"
      }],
      "rules" => [{
        "id" => "rule_override", "flag_id" => "flag1", "account_id" => "acc_1",
        "environment_id" => "env_1", "name" => "Company Override",
        "rule_type" => "company_override", "priority" => 0, "value" => true,
        "condition_groups" => [],
        "conditions" => [
          {
            "id" => "cond_company", "account_id" => "acc_1", "environment_id" => "env_1",
            "condition_type" => "company", "operator" => "eq",
            "resource_ids" => ["co_entitled"], "trait_value" => ""
          },
          {
            "id" => "cond_metric", "account_id" => "acc_1", "environment_id" => "env_1",
            "condition_type" => "metric", "operator" => "lt", "event_subtype" => "api-calls",
            "metric_value" => 100, "metric_period" => "current_month",
            "metric_period_month_reset" => "billing_cycle", "trait_value" => "100"
          }
        ]
      }]
    }
  end

  def test_billing_metric_override_evaluates_without_trapping
    result = @engine.check_flag(flag, entitled_company)
    assert_equal true, result[:value],
                 "company override should grant the flag, not fall back to default false"
    assert_match(/override/i, result[:reason].to_s)
  end

  def test_billing_metric_override_populates_reset_at
    result = @engine.check_flag(flag, entitled_company)
    refute_nil result[:feature_usage_reset_at],
               "reset-at should be computed from the injected host time"
  end
end
