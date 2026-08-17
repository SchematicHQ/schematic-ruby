# frozen_string_literal: true

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
