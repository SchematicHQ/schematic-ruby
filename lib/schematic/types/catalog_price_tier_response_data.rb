# frozen_string_literal: true

module Schematic
  module Types
    class CatalogPriceTierResponseData < Internal::Types::Model
      field :flat_price, -> { Integer }, optional: true, nullable: false

      field :from, -> { Integer }, optional: false, nullable: false

      field :per_unit_price, -> { Integer }, optional: true, nullable: false

      field :per_unit_price_decimal, -> { String }, optional: true, nullable: false

      field :to, -> { Integer }, optional: true, nullable: false
    end
  end
end
