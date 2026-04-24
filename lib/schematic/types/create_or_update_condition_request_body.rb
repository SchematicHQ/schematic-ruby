# frozen_string_literal: true

module Schematic
  module Types
    class CreateOrUpdateConditionRequestBody < Internal::Types::Model
      field :comparison_trait_id, -> { String }, optional: true, nullable: false
      field :condition_type, -> { Schematic::Types::ConditionType }, optional: false, nullable: false
      field :credit_cost, -> { Integer }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: true, nullable: false
      field :event_subtype, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: true, nullable: false
      field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false
      field :metric_value, -> { Integer }, optional: true, nullable: false
      field :operator, -> { Schematic::Types::ComparableOperator }, optional: false, nullable: false
      field :resource_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :trait_id, -> { String }, optional: true, nullable: false
      field :trait_value, -> { String }, optional: true, nullable: false
    end
  end
end
