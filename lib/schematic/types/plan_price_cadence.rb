# frozen_string_literal: true

require_relative "../../schematic"

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
