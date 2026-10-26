# frozen_string_literal: true

module Schematic
  module Types
    class CatalogCreditBundleResponseData < Internal::Types::Model
      field :bundle_type, -> { String }, optional: false, nullable: false

      field :compatible_plan_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :credit_icon, -> { String }, optional: true, nullable: false

      field :credit_id, -> { String }, optional: false, nullable: false

      field :credit_name, -> { String }, optional: false, nullable: false

      field :credit_plural_name, -> { String }, optional: true, nullable: false

      field :credit_singular_name, -> { String }, optional: true, nullable: false

      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::CatalogBundleCurrencyPriceResponseData] }, optional: false, nullable: false

      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: false, nullable: false

      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: false, nullable: false

      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :quantity, -> { Integer }, optional: true, nullable: false

      field :unit_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false
    end
  end
end
