# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module OnboardingTrack
      extend Schematic::Internal::Types::Enum

      CATALOG = "catalog"
      SINGLE_PLAN = "single_plan"
    end
  end
end
