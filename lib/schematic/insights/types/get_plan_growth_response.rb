# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      class GetPlanGrowthResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanGrowthResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Insights::Types::GetPlanGrowthParams }, optional: false, nullable: false
      end
    end
  end
end
