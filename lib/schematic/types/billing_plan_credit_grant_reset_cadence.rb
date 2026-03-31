# frozen_string_literal: true

module Schematic
  module Types
    module BillingPlanCreditGrantResetCadence
      extend Schematic::Internal::Types::Enum

      DAILY = "daily"
      MONTHLY = "monthly"
      WEEKLY = "weekly"
      YEARLY = "yearly"
    end
  end
end
