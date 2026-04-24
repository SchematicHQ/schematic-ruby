# frozen_string_literal: true

module Schematic
  module Types
    class CompanyDetailResponseData < Internal::Types::Model
      field :add_ons, -> { Internal::Types::Array[Schematic::Types::CompanyPlanWithBillingSubView] }, optional: false, nullable: false
      field :billing_credit_balances, -> { Internal::Types::Hash[String, Integer] }, optional: true, nullable: false
      field :billing_subscription, -> { Schematic::Types::BillingSubscriptionView }, optional: true, nullable: false
      field :billing_subscriptions, -> { Internal::Types::Array[Schematic::Types::BillingSubscriptionView] }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :custom_plan_billings, -> { Internal::Types::Array[Schematic::Types::CustomPlanBillingResponseData] }, optional: false, nullable: false
      field :default_payment_method, -> { Schematic::Types::PaymentMethodResponseData }, optional: true, nullable: false
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::FeatureEntitlement] }, optional: false, nullable: false
      field :entity_traits, -> { Internal::Types::Array[Schematic::Types::EntityTraitDetailResponseData] }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :keys, -> { Internal::Types::Array[Schematic::Types::EntityKeyDetailResponseData] }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :logo_url, -> { String }, optional: true, nullable: false
      field :metrics, -> { Internal::Types::Array[Schematic::Types::CompanyEventPeriodMetricsResponseData] }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :payment_methods, -> { Internal::Types::Array[Schematic::Types::PaymentMethodResponseData] }, optional: false, nullable: false
      field :plan, -> { Schematic::Types::CompanyPlanWithBillingSubView }, optional: true, nullable: false
      field :plans, -> { Internal::Types::Array[Schematic::Types::GenericPreviewObject] }, optional: false, nullable: false
      field :rules, -> { Internal::Types::Array[Schematic::Types::Rule] }, optional: false, nullable: false
      field :scheduled_downgrade, -> { Schematic::Types::ScheduledDowngradeResponseData }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :user_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
