# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetPlanChangeResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanChangeResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
