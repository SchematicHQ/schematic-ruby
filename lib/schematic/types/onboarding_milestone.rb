# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module OnboardingMilestone
      extend Schematic::Internal::Types::Enum

      EVALUATED = "evaluated"
      IMPLEMENTED = "implemented"
    end
  end
end
