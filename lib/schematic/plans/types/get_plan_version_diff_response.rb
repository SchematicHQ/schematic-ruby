# frozen_string_literal: true

require_relative "../../../schematic"

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
