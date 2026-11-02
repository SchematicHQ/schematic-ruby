# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module FeatureLifecyclePhase
      extend Schematic::Internal::Types::Enum

      ADD_ON = "add_on"
      ALPHA = "alpha"
      BETA = "beta"
      DEPRECATED = "deprecated"
      GA = "ga"
      INACTIVE = "inactive"
      IN_PLAN = "in_plan"
      INTERNAL_TESTING = "internal_testing"
      LEGACY = "legacy"
    end
  end
end
