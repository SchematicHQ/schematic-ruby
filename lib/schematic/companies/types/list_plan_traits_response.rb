# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListPlanTraitsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanTraitResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListPlanTraitsParams }, optional: false, nullable: false
      end
    end
  end
end
