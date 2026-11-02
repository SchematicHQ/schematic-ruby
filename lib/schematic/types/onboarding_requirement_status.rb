# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module OnboardingRequirementStatus
      extend Schematic::Internal::Types::Enum

      AVAILABLE = "available"
      BLOCKED = "blocked"
      COMPLETE = "complete"
    end
  end
end
