# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanVersionMigrationStrategy
      extend Schematic::Internal::Types::Enum

      END_OF_BILLING_PERIOD = "end_of_billing_period"
      IMMEDIATE = "immediate"
      LEAVE = "leave"
      SCHEDULED = "scheduled"
    end
  end
end
