# frozen_string_literal: true

module Schematic
  module Types
    class CurrencyPriceRequestBody < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :monthly_price_tiers, -> { Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody] }, optional: true, nullable: false
      field :monthly_unit_price, -> { Integer }, optional: true, nullable: false
      field :monthly_unit_price_decimal, -> { String }, optional: true, nullable: false
      field :yearly_price_tiers, -> { Internal::Types::Array[Schematic::Types::CreatePriceTierRequestBody] }, optional: true, nullable: false
      field :yearly_unit_price, -> { Integer }, optional: true, nullable: false
      field :yearly_unit_price_decimal, -> { String }, optional: true, nullable: false
    end
  end
end
