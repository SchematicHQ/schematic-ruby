# frozen_string_literal: true

module Schematic
  module Types
    module PlanPriceCadence
      extend Schematic::Internal::Types::Enum

      MONTHLY = "monthly"
      QUARTERLY = "quarterly"
      YEARLY = "yearly"
    end
  end
end
