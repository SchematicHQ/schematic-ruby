# frozen_string_literal: true

module Schematic
  module Types
    module BillingPlanCreditGrantResetCadence
      extend Schematic::Internal::Types::Enum

      DAILY = "daily"
      EVERY_6_MONTHS = "every_6_months"
      MONTHLY = "monthly"
      QUARTERLY = "quarterly"
      WEEKLY = "weekly"
      YEARLY = "yearly"
    end
  end
end
