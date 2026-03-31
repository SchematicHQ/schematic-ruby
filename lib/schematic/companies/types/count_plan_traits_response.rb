# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountPlanTraitsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::CountPlanTraitsParams }, optional: false, nullable: false
      end
    end
  end
end
