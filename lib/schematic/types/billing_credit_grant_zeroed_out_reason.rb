# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditGrantZeroedOutReason
      extend Schematic::Internal::Types::Enum

      EXPIRED = "expired"
      MANUAL = "manual"
      PLAN_CHANGE = "plan_change"
      PLAN_PERIOD_RESET = "plan_period_reset"
    end
  end
end
