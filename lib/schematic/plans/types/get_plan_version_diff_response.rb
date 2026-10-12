# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class GetPlanVersionDiffResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanVersionDiffResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::GetPlanVersionDiffParams }, optional: false, nullable: false
      end
    end
  end
end
