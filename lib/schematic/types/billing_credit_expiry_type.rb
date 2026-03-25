# frozen_string_literal: true

module Schematic
  module Types
    module BillingCreditExpiryType
      extend Schematic::Internal::Types::Enum

      DURATION = "duration"
      END_OF_BILLING_PERIOD = "end_of_billing_period"
      END_OF_NEXT_BILLING_PERIOD = "end_of_next_billing_period"
      END_OF_TRIAL = "end_of_trial"
      NO_EXPIRY = "no_expiry"
    end
  end
end
