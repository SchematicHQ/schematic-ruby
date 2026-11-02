# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class GetPlanResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanDetailResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::GetPlanParams }, optional: false, nullable: false
      end
    end
  end
end
