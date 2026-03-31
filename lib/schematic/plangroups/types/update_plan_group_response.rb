# frozen_string_literal: true

module Schematic
  module Plangroups
    module Types
      class UpdatePlanGroupResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanGroupResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
