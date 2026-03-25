# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class UpdatePlanTraitResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanTraitResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
