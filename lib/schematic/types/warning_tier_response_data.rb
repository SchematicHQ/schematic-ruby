# frozen_string_literal: true

module Schematic
  module Types
    class WarningTierResponseData < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :value, -> { Integer }, optional: false, nullable: false
    end
  end
end
