# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingPlanCreditGrantResetType
      extend Schematic::Internal::Types::Enum

      NO_RESET = "no_reset"
      PLAN_PERIOD = "plan_period"
    end
  end
end
