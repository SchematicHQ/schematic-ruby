# frozen_string_literal: true

module Schematic
  module Types
    class CreditBurnBreakdownLine < Internal::Types::Model
      field :credits, -> { Float }, optional: false, nullable: false

      field :key, -> { String }, optional: false, nullable: false

      field :quantity, -> { Float }, optional: false, nullable: false

      field :rate, -> { Float }, optional: false, nullable: false
    end
  end
end
