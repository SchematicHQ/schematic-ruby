# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreateBillingSubscriptionRequestBody < Internal::Types::Model
        field :application_id, -> { String }, optional: true, nullable: false
        field :cancel_at, -> { Integer }, optional: true, nullable: false
        field :cancel_at_period_end, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :currency, -> { String }, optional: false, nullable: false
        field :customer_external_id, -> { String }, optional: false, nullable: false
        field :default_payment_method_external_id, -> { String }, optional: true, nullable: false
        field :default_payment_method_id, -> { String }, optional: true, nullable: false
        field :discounts, -> { Internal::Types::Array[Schematic::Types::BillingSubscriptionDiscount] }, optional: false, nullable: false
        field :expired_at, -> { String }, optional: false, nullable: false
        field :interval, -> { String }, optional: true, nullable: false
        field :metadata, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
        field :period_end, -> { Integer }, optional: true, nullable: false
        field :period_start, -> { Integer }, optional: true, nullable: false
        field :product_external_ids, -> { Internal::Types::Array[Schematic::Types::BillingProductPricing] }, optional: false, nullable: false
        field :status, -> { String }, optional: true, nullable: false
        field :subscription_external_id, -> { String }, optional: false, nullable: false
        field :total_price, -> { Integer }, optional: false, nullable: false
        field :trial_end, -> { Integer }, optional: true, nullable: false
        field :trial_end_setting, -> { Schematic::Types::BillingSubscriptionTrialEndSetting }, optional: true, nullable: false
      end
    end
  end
end
