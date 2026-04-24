# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineFeatureEntitlement < Internal::Types::Model
      field :allocation, -> { Integer }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: true, nullable: false
      field :credit_remaining, -> { Integer }, optional: true, nullable: false
      field :credit_total, -> { Integer }, optional: true, nullable: false
      field :credit_used, -> { Integer }, optional: true, nullable: false
      field :event_name, -> { String }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :feature_key, -> { String }, optional: false, nullable: false
      field :metric_period, -> { Schematic::Types::RulesengineMetricPeriod }, optional: true, nullable: false
      field :metric_reset_at, -> { String }, optional: true, nullable: false
      field :month_reset, -> { Schematic::Types::RulesengineMetricPeriodMonthReset }, optional: true, nullable: false
      field :soft_limit, -> { Integer }, optional: true, nullable: false
      field :usage, -> { Integer }, optional: true, nullable: false
      field :value_type, -> { Schematic::Types::RulesengineEntitlementValueType }, optional: false, nullable: false
    end
  end
end
