# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionDiffPriceCadence
      extend Schematic::Internal::Types::Enum

      MONTHLY = "monthly"
      ONE_TIME = "one_time"
      QUARTERLY = "quarterly"
      YEARLY = "yearly"
    end
  end
end
