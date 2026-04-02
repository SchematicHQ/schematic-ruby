# frozen_string_literal: true

module Schematic
  module Types
    class UsageBasedEntitlementRequestBody < Internal::Types::Model
      field :billing_product_id, -> { String }, optional: true, nullable: false
      field :billing_threshold, -> { Integer }, optional: true, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::CurrencyPriceRequestBody] }, optional: true, nullable: false
      field :monthly_metered_price_id, -> { String }, optional: true, nullable: false
      field :monthly_price_tiers, -> { Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody] }, optional: true, nullable: false
      field :monthly_unit_price, -> { Integer }, optional: true, nullable: false
      field :monthly_unit_price_decimal, -> { String }, optional: true, nullable: false
      field :overage_billing_product_id, -> { String }, optional: true, nullable: false
      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false
      field :price_tiers, -> { Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody] }, optional: true, nullable: false
      field :soft_limit, -> { Integer }, optional: true, nullable: false
      field :tier_mode, -> { Schematic::Types::BillingTiersMode }, optional: true, nullable: false
      field :yearly_metered_price_id, -> { String }, optional: true, nullable: false
      field :yearly_price_tiers, -> { Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody] }, optional: true, nullable: false
      field :yearly_unit_price, -> { Integer }, optional: true, nullable: false
      field :yearly_unit_price_decimal, -> { String }, optional: true, nullable: false
    end
  end
end
