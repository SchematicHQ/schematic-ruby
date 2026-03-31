# frozen_string_literal: true

module Schematic
  module Plangroups
    module Types
      class GetPlanGroupResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanGroupDetailResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Plangroups::Types::GetPlanGroupParams }, optional: false, nullable: false
      end
    end
  end
end
