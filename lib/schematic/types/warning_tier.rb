# frozen_string_literal: true

module Schematic
  module Types
    class WarningTier < Internal::Types::Model
      field :key, -> { String }, optional: false, nullable: false
      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
