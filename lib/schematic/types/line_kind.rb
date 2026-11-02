# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module LineKind
      extend Schematic::Internal::Types::Enum

      ALLOWANCE = "allowance"
      CAPACITY = "capacity"
      RATE = "rate"
    end
  end
end
