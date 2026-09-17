# frozen_string_literal: true

module Schematic
  module Types
    module BillingArrearsCadence
      extend Schematic::Internal::Types::Enum

      END_OF_BILLING_PERIOD = "end_of_billing_period"
      MONTHLY = "monthly"
      QUARTERLY = "quarterly"
    end
  end
end
