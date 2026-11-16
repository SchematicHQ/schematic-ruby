# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CreditLedgerExportMetadataEventType
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
