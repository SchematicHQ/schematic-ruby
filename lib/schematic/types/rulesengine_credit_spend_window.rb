# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineCreditSpendWindow < Internal::Types::Model
      field :count, -> { Integer }, optional: false, nullable: false

      field :unit, -> { String }, optional: false, nullable: false
    end
  end
end
