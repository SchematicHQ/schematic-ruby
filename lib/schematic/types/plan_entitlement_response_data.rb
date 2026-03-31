# frozen_string_literal: true

module Schematic
  module Types
    class PlanEntitlementResponseData < Internal::Types::Model
      field :billing_threshold, -> { Integer }, optional: true, nullable: false
      field :consumption_rate, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::EntitlementCurrencyPricesResponseData] }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureResponseData }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :metered_monthly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :metered_yearly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :metric_period, -> { String }, optional: true, nullable: false
      field :metric_period_month_reset, -> { String }, optional: true, nullable: false
      field :plan, -> { Schematic::Types::PlanResponseData }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false
      field :rule_id, -> { String }, optional: false, nullable: false
      field :rule_id_usage_exceeded, -> { String }, optional: true, nullable: false
      field :soft_limit, -> { Integer }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :usage_based_product, -> { Schematic::Types::BillingProductResponseData }, optional: true, nullable: false
      field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :value_credit, -> { Schematic::Types::BillingCreditResponseData }, optional: true, nullable: false
      field :value_numeric, -> { Integer }, optional: true, nullable: false
      field :value_trait, -> { Schematic::Types::EntityTraitDefinitionResponseData }, optional: true, nullable: false
      field :value_trait_id, -> { String }, optional: true, nullable: false
      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
    end
  end
end
