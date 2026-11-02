# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CreditLedgerSourceType
      extend Schematic::Internal::Types::Enum

      BILLING_CHARGE = "billing_charge"
      BILLING_CREDIT_GRANT = "billing_credit_grant"
      BILLING_CREDIT_TRANSFER = "billing_credit_transfer"
      BILLING_SETTLEMENT = "billing_settlement"
    end
  end
end
