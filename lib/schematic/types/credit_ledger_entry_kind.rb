# frozen_string_literal: true

module Schematic
  module Types
    module CreditLedgerEntryKind
      extend Schematic::Internal::Types::Enum

      ADJUSTMENT = "adjustment"
      CHARGE = "charge"
      DRAWDOWN = "drawdown"
      GRANT = "grant"
      SETTLEMENT = "settlement"
      TRANSFER = "transfer"
      ZERO_OUT = "zero_out"
    end
  end
end
