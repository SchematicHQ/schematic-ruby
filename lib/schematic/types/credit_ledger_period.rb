# frozen_string_literal: true

module Schematic
  module Types
    module CreditLedgerPeriod
      extend Schematic::Internal::Types::Enum

      DAILY = "daily"
      MONTHLY = "monthly"
      RAW = "raw"
      WEEKLY = "weekly"
    end
  end
end
