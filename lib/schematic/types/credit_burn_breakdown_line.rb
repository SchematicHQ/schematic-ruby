# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditBurnBreakdownLine < Internal::Types::Model
      field :credits, -> { Float }, optional: false, nullable: false

      field :key, -> { String }, optional: false, nullable: false

      field :model, -> { String }, optional: true, nullable: false

      field :provider, -> { String }, optional: true, nullable: false

      field :quantity, -> { Float }, optional: false, nullable: false

      field :rate, -> { Float }, optional: false, nullable: false
    end
  end
end
