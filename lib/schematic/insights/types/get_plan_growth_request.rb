# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      class GetPlanGrowthRequest < Internal::Types::Model
        field :months, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
