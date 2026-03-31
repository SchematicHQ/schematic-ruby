# frozen_string_literal: true

module Schematic
  module Types
    class PlanGroupPlanDetailResponseData < Internal::Types::Model
      field :active_version, -> { Schematic::Types::PlanVersionResponseData }, optional: true, nullable: false
      field :audience_type, -> { String }, optional: true, nullable: false
      field :billing_product, -> { Schematic::Types::BillingProductDetailResponseData }, optional: true, nullable: false
      field :charge_type, -> { Schematic::Types::ChargeType }, optional: false, nullable: false
      field :company_count, -> { Integer }, optional: false, nullable: false
      field :compatible_plan_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :controlled_by, -> { Schematic::Types::PlanControlledByType }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::PlanCurrencyPricesResponseData] }, optional: false, nullable: false
      field :custom_plan_config, -> { Schematic::Types::CustomPlanViewConfigResponseData }, optional: true, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :draft_version, -> { Schematic::Types::PlanVersionResponseData }, optional: true, nullable: false
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementResponseData] }, optional: false, nullable: false
      field :features, -> { Internal::Types::Array[Schematic::Types::FeatureDetailResponseData] }, optional: false, nullable: false
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :included_credit_grants, -> { Internal::Types::Array[Schematic::Types::BillingPlanCreditGrantResponseData] }, optional: true, nullable: false
      field :is_custom, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :is_default, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :is_free, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :is_trialable, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :monthly_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :one_time_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
      field :trial_days, -> { Integer }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :versions, -> { Internal::Types::Array[Schematic::Types::PlanVersionResponseData] }, optional: false, nullable: false
      field :yearly_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
    end
  end
end
