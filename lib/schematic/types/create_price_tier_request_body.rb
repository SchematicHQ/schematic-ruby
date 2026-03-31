# frozen_string_literal: true

module Schematic
  module Types
    class CreatePriceTierRequestBody < Internal::Types::Model
      field :flat_amount, -> { Integer }, optional: true, nullable: false
      field :per_unit_price, -> { Integer }, optional: true, nullable: false
      field :per_unit_price_decimal, -> { String }, optional: true, nullable: false
      field :up_to, -> { Integer }, optional: true, nullable: false
    end
  end
end
