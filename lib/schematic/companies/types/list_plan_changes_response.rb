# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListPlanChangesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanChangeResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListPlanChangesParams }, optional: false, nullable: false
      end
    end
  end
end
