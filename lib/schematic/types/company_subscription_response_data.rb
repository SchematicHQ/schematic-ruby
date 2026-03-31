# frozen_string_literal: true

module Schematic
  module Types
    class CompanySubscriptionResponseData < Internal::Types::Model
      field :cancel_at, -> { String }, optional: true, nullable: false
      field :cancel_at_period_end, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :customer_external_id, -> { String }, optional: false, nullable: false
      field :discounts, -> { Internal::Types::Array[Schematic::Types::BillingSubscriptionDiscountView] }, optional: false, nullable: false
      field :expired_at, -> { String }, optional: true, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :latest_invoice, -> { Schematic::Types::InvoiceResponseData }, optional: true, nullable: false
      field :payment_method, -> { Schematic::Types::PaymentMethodResponseData }, optional: true, nullable: false
      field :products, -> { Internal::Types::Array[Schematic::Types::BillingProductForSubscriptionResponseData] }, optional: false, nullable: false
      field :status, -> { String }, optional: false, nullable: false
      field :subscription_external_id, -> { String }, optional: false, nullable: false
      field :total_price, -> { Integer }, optional: false, nullable: false
      field :trial_end, -> { String }, optional: true, nullable: false
    end
  end
end
