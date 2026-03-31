# frozen_string_literal: true

module Schematic
  module Types
    class CreditCurrencyPriceRequestBody < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :price_per_unit, -> { Integer }, optional: true, nullable: false
      field :price_per_unit_decimal, -> { String }, optional: true, nullable: false
    end
  end
end
