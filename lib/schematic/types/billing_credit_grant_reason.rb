# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditGrantReason
      extend Schematic::Internal::Types::Enum

      BILLING_CREDIT_AUTO_TOPUP = "billing_credit_auto_topup"
      FREE = "free"
      PLAN = "plan"
      PURCHASED = "purchased"
    end
  end
end
