# frozen_string_literal: true

module Schematic
  module Types
    class FeatureEntitlement < Internal::Types::Model
      field :allocation, -> { Integer }, optional: true, nullable: false

      field :consumption_rate, -> { Integer }, optional: true, nullable: false

      field :credit_id, -> { String }, optional: true, nullable: false

      field :credit_remaining, -> { Integer }, optional: true, nullable: false

      field :credit_reserved, -> { Integer }, optional: true, nullable: false

      field :credit_settled, -> { Integer }, optional: true, nullable: false

      field :credit_total, -> { Integer }, optional: true, nullable: false

      field :credit_used, -> { Integer }, optional: true, nullable: false

      field :event_name, -> { String }, optional: true, nullable: false

      field :event_subtype, -> { String }, optional: true, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :feature_key, -> { String }, optional: false, nullable: false

      field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false

      field :metric_reset_at, -> { String }, optional: true, nullable: false

      field :month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false

      field :soft_limit, -> { Integer }, optional: true, nullable: false

      field :usage, -> { Integer }, optional: true, nullable: false

      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false

      field :warning_tiers, -> { Internal::Types::Array[Schematic::Types::WarningTier] }, optional: true, nullable: false
    end
  end
end
