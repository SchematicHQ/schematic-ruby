# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCheckFlagResult < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false
      field :entitlement, -> { Schematic::Types::RulesengineFeatureEntitlement }, optional: true, nullable: false
      field :err, -> { String }, optional: true, nullable: false
      field :feature_allocation, -> { Integer }, optional: true, nullable: false
      field :feature_usage, -> { Integer }, optional: true, nullable: false
      field :feature_usage_event, -> { String }, optional: true, nullable: false
      field :feature_usage_period, -> { Schematic::Types::RulesengineMetricPeriod }, optional: true, nullable: false
      field :feature_usage_reset_at, -> { String }, optional: true, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :flag_key, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :rule_id, -> { String }, optional: true, nullable: false
      field :rule_type, -> { Schematic::Types::RulesengineRuleType }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
