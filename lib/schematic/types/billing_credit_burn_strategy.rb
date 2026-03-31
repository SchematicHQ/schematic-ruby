# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditBurnStrategy
      extend Schematic::Internal::Types::Enum

      EXPIRATION_PRIORITY = "expiration_priority"
      FIRST_IN_FIRST_OUT = "first_in_first_out"
      LAST_IN_FIRST_OUT = "last_in_first_out"
      PLAN_FIRST_THEN_CREDIT_BUNDLES_FIRST_IN_FIRST_OUT = "plan_first_then_credit_bundles_first_in_first_out"
    end
  end
end
