# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditGrantReason
      extend Schematic::Internal::Types::Enum

      ADJUSTMENT = "adjustment"
      BILLING_CREDIT_AUTO_TOPUP = "billing_credit_auto_topup"
      FREE = "free"
      PLAN = "plan"
      POSTPAID_FORGIVEN = "postpaid_forgiven"
      POSTPAID_OVERDRAFT = "postpaid_overdraft"
      POSTPAID_SETTLEMENT = "postpaid_settlement"
      PURCHASED = "purchased"
      ROLLOVER = "rollover"
    end
  end
end
