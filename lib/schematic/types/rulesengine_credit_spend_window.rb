# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class RulesengineCreditSpendWindow < Internal::Types::Model
      field :count, -> { Integer }, optional: false, nullable: false

      field :unit, -> { String }, optional: false, nullable: false
    end
  end
end
