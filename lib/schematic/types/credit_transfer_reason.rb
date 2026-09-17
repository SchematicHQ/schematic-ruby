# frozen_string_literal: true

module Schematic
  module Types
    module CreditTransferReason
      extend Schematic::Internal::Types::Enum

      OVERDRAFT_RECOVERY = "overdraft_recovery"
      POSTPAID_DEBT_MOVED = "postpaid_debt_moved"
      POSTPAID_FORGIVEN = "postpaid_forgiven"
      POSTPAID_PAID = "postpaid_paid"
    end
  end
end
