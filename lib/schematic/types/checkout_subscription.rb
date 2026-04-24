# frozen_string_literal: true

module Schematic
  module Types
    class CheckoutSubscription < Internal::Types::Model
      field :application_id, -> { String }, optional: true, nullable: false
      field :cancel_at, -> { Integer }, optional: true, nullable: false
      field :cancel_at_period_end, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :company_id, -> { String }, optional: true, nullable: false
      field :confirm_payment_intent_client_secret, -> { String }, optional: true, nullable: false
      field :confirm_payment_intent_id, -> { String }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :customer_external_id, -> { String }, optional: false, nullable: false
      field :default_payment_method_id, -> { String }, optional: true, nullable: false
      field :expired_at, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :invoice_url, -> { String }, optional: true, nullable: false
      field :metadata, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :period_end, -> { Integer }, optional: false, nullable: false
      field :period_start, -> { Integer }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :status, -> { String }, optional: false, nullable: false
      field :subscription_external_id, -> { String }, optional: false, nullable: false
      field :total_price, -> { Integer }, optional: false, nullable: false
      field :trial_end, -> { Integer }, optional: true, nullable: false
      field :trial_end_setting, -> { Schematic::Types::BillingSubscriptionTrialEndSetting }, optional: true, nullable: false
    end
  end
end
