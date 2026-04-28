# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      # Input parameters
      class GetPlanGrowthParams < Internal::Types::Model
        field :months, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
