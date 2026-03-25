# frozen_string_literal: true

module Schematic
  module Types
    class ComponentHydrateResponseData < Internal::Types::Model
      field :active_add_ons, -> { Internal::Types::Array[Schematic::Types::CompanyPlanDetailResponseData] }, optional: false, nullable: false
      field :active_plans, -> { Internal::Types::Array[Schematic::Types::CompanyPlanDetailResponseData] }, optional: false, nullable: false
      field :active_usage_based_entitlements, -> { Internal::Types::Array[Schematic::Types::UsageBasedEntitlementResponseData] }, optional: false, nullable: false
      field :add_on_compatibilities, -> { Internal::Types::Array[Schematic::Types::CompatiblePlans] }, optional: false, nullable: false
      field :capabilities, -> { Schematic::Types::ComponentCapabilities }, optional: true, nullable: false
      field :checkout_settings, -> { Schematic::Types::ComponentCheckoutSettings }, optional: false, nullable: false
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
      field :component, -> { Schematic::Types::ComponentResponseData }, optional: true, nullable: false
      field :credit_bundles, -> { Internal::Types::Array[Schematic::Types::BillingCreditBundleView] }, optional: false, nullable: false
      field :credit_grants, -> { Internal::Types::Array[Schematic::Types::CreditCompanyGrantView] }, optional: false, nullable: false
      field :default_plan, -> { Schematic::Types::PlanDetailResponseData }, optional: true, nullable: false
      field :display_settings, -> { Schematic::Types::ComponentDisplaySettings }, optional: false, nullable: false
      field :feature_usage, -> { Schematic::Types::FeatureUsageDetailResponseData }, optional: true, nullable: false
      field :post_trial_plan, -> { Schematic::Types::PlanDetailResponseData }, optional: true, nullable: false
      field :prevent_self_service_downgrade, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :prevent_self_service_downgrade_button_text, -> { String }, optional: true, nullable: false
      field :prevent_self_service_downgrade_url, -> { String }, optional: true, nullable: false
      field :scheduled_downgrade, -> { Schematic::Types::ScheduledDowngradeResponseData }, optional: true, nullable: false
      field :show_as_monthly_prices, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_credits, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_period_toggle, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :show_zero_price_as_free, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :stripe_embed, -> { Schematic::Types::StripeEmbedInfo }, optional: true, nullable: false
      field :subscription, -> { Schematic::Types::CompanySubscriptionResponseData }, optional: true, nullable: false
      field :trial_payment_method_required, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :upcoming_invoice, -> { Schematic::Types::InvoiceResponseData }, optional: true, nullable: false
    end
  end
end
