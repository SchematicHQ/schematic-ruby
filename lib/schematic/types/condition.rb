# frozen_string_literal: true

module Schematic
  module Types
    class Condition < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :comparison_trait_definition, -> { Schematic::Types::TraitDefinition }, optional: true, nullable: false
      field :condition_type, -> { Schematic::Types::ConditionConditionType }, optional: false, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metric_period, -> { Schematic::Types::ConditionMetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::ConditionMetricPeriodMonthReset }, optional: true, nullable: false
      field :metric_value, -> { Integer }, optional: true, nullable: false
      field :operator, -> { Schematic::Types::ConditionOperator }, optional: false, nullable: false
      field :resource_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :trait_definition, -> { Schematic::Types::TraitDefinition }, optional: true, nullable: false
      field :trait_value, -> { String }, optional: false, nullable: false
    end
  end
end
