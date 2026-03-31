# frozen_string_literal: true

module Schematic
  module Types
    class FeatureUsageResponseData < Internal::Types::Model
      field :access, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :allocation, -> { Integer }, optional: true, nullable: false
      field :allocation_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
      field :company_override, -> { Schematic::Types::CompanyOverrideResponseData }, optional: true, nullable: false
      field :credit_consumption_rate, -> { Integer }, optional: true, nullable: false
      field :credit_grant_counts, -> { Internal::Types::Hash[String, Integer] }, optional: true, nullable: false
      field :credit_grant_details, -> { Internal::Types::Array[Schematic::Types::CreditGrantDetail] }, optional: true, nullable: false
      field :credit_grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: true, nullable: false
      field :credit_remaining, -> { Integer }, optional: true, nullable: false
      field :credit_total, -> { Integer }, optional: true, nullable: false
      field :credit_type_icon, -> { String }, optional: true, nullable: false
      field :credit_usage_aggregation, -> { Schematic::Types::CreditUsageAggregation }, optional: true, nullable: false
      field :credit_used, -> { Integer }, optional: true, nullable: false
      field :effective_limit, -> { Integer }, optional: true, nullable: false
      field :effective_price, -> { Integer }, optional: true, nullable: false
      field :entitlement_expiration_date, -> { String }, optional: true, nullable: false
      field :entitlement_id, -> { String }, optional: false, nullable: false
      field :entitlement_source, -> { String }, optional: true, nullable: false
      field :entitlement_type, -> { Schematic::Types::EntitlementType }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureDetailResponseData }, optional: true, nullable: false
      field :has_valid_allocation, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :is_unlimited, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :metric_reset_at, -> { String }, optional: true, nullable: false
      field :month_reset, -> { String }, optional: true, nullable: false
      field :monthly_usage_based_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :overuse, -> { Integer }, optional: true, nullable: false
      field :percent_used, -> { Integer }, optional: true, nullable: false
      field :period, -> { String }, optional: true, nullable: false
      field :plan, -> { Schematic::Types::PlanResponseData }, optional: true, nullable: false
      field :plan_entitlement, -> { Schematic::Types::PlanEntitlementResponseData }, optional: true, nullable: false
      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false
      field :soft_limit, -> { Integer }, optional: true, nullable: false
      field :usage, -> { Integer }, optional: true, nullable: false
      field :yearly_usage_based_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
