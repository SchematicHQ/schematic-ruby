# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCondition < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :comparison_trait_definition, -> { Schematic::Types::RulesengineTraitDefinition }, optional: true, nullable: false
      field :condition_type, -> { Schematic::Types::RulesengineConditionConditionType }, optional: false, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metric_period, -> { Schematic::Types::RulesengineConditionMetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::RulesengineConditionMetricPeriodMonthReset }, optional: true, nullable: false
      field :metric_value, -> { Integer }, optional: true, nullable: false
      field :operator, -> { Schematic::Types::RulesengineConditionOperator }, optional: false, nullable: false
      field :resource_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :trait_definition, -> { Schematic::Types::RulesengineTraitDefinition }, optional: true, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
    end
  end
end
