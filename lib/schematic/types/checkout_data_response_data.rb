# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutDataResponseData < Internal::Types::Model
      field :active_add_ons, -> { Internal::Types::Array[Schematic::Types::PlanDetailResponseData] }, optional: false, nullable: false
      field :active_plan, -> { Schematic::Types::PlanDetailResponseData }, optional: true, nullable: false
      field :active_usage_based_entitlements, -> { Internal::Types::Array[Schematic::Types::UsageBasedEntitlementResponseData] }, optional: false, nullable: false
      field :available_credit_bundles, -> { Internal::Types::Array[Schematic::Types::BillingCreditBundleResponseData] }, optional: false, nullable: false
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
      field :feature_usage, -> { Schematic::Types::FeatureUsageDetailResponseData }, optional: true, nullable: false
      field :selected_credit_bundles, -> { Internal::Types::Array[Schematic::Types::CreditBundlePurchaseResponseData] }, optional: false, nullable: false
      field :selected_plan, -> { Schematic::Types::PlanDetailResponseData }, optional: true, nullable: false
      field :selected_usage_based_entitlements, -> { Internal::Types::Array[Schematic::Types::UsageBasedEntitlementResponseData] }, optional: false, nullable: false
      field :subscription, -> { Schematic::Types::CompanySubscriptionResponseData }, optional: true, nullable: false
    end
  end
end
