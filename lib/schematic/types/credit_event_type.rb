# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CreditEventType
      extend Schematic::Internal::Types::Enum

      ADJUSTMENT = "adjustment"
      CHARGE = "charge"
      GRANT = "grant"
      SETTLEMENT = "settlement"
      TRANSFER = "transfer"
      USAGE = "usage"
      ZERO_OUT = "zero_out"
    end
  end
end
