# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditGrantPriceTierRequestBody < Internal::Types::Model
      field :per_unit_price, -> { Integer }, optional: true, nullable: false

      field :per_unit_price_decimal, -> { String }, optional: true, nullable: false

      field :up_to, -> { Integer }, optional: true, nullable: false
    end
  end
end
