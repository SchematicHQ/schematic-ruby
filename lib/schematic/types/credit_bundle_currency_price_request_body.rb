# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditBundleCurrencyPriceRequestBody < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :price_per_unit, -> { Integer }, optional: true, nullable: false

      field :price_per_unit_decimal, -> { String }, optional: true, nullable: false
    end
  end
end
