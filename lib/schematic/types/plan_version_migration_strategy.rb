# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionMigrationStrategy
      extend Schematic::Internal::Types::Enum

      END_OF_BILLING_PERIOD = "end_of_billing_period"
      IMMEDIATE = "immediate"
      LEAVE = "leave"
    end
  end
end
