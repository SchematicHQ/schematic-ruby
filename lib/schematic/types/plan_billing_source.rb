# frozen_string_literal: true

module Schematic
  module Types
    module PlanBillingSource
      extend Schematic::Internal::Types::Enum

      AMENDMENT = "amendment"
      CUSTOM_PLAN = "custom_plan"
      MANAGE_PLAN = "manage_plan"
    end
  end
end
