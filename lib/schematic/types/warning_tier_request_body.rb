# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class WarningTierRequestBody < Internal::Types::Model
      field :key, -> { String }, optional: false, nullable: false

      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
