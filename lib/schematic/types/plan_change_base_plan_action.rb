# frozen_string_literal: true

module Schematic
  module Types
    module PlanChangeBasePlanAction
      extend Schematic::Internal::Types::Enum

      FALLBACK = "fallback"
      INITIAL = "initial"
      TRAIT = "trait"
      TRIAL_EXPIRY = "trial_expiry"
    end
  end
end
