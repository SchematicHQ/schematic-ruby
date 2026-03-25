# frozen_string_literal: true

module Schematic
  module Types
    module CreditEventType
      extend Schematic::Internal::Types::Enum

      GRANT = "grant"
      TRANSFER = "transfer"
      USAGE = "usage"
      ZERO_OUT = "zero_out"
    end
  end
end
