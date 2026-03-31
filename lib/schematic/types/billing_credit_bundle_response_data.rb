# frozen_string_literal: true

module Schematic
  module Types
    class BillingCreditBundleResponseData < Internal::Types::Model
      field :billing_invoice_id, -> { String }, optional: true, nullable: false
      field :bundle_type, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit_description, -> { String }, optional: true, nullable: false
      field :credit_icon, -> { String }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: false, nullable: false
      field :credit_name, -> { String }, optional: false, nullable: false
      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::CreditBundleCurrencyPriceResponseData] }, optional: false, nullable: false
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: false, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: false, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :has_grants, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plural_name, -> { String }, optional: true, nullable: false
      field :price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :quantity, -> { Integer }, optional: true, nullable: false
      field :singular_name, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::BillingCreditBundleStatus }, optional: false, nullable: false
      field :unit_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
