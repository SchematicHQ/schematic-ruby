# frozen_string_literal: true

module Schematic
  module Types
    class UsageBasedEntitlementResponseData < Internal::Types::Model
      field :billing_threshold, -> { Integer }, optional: true, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :metered_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :metric_period, -> { String }, optional: true, nullable: false
      field :metric_period_month_reset, -> { String }, optional: true, nullable: false
      field :monthly_usage_based_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false
      field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :value_numeric, -> { Integer }, optional: true, nullable: false
      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
      field :yearly_usage_based_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
