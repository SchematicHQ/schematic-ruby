# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountEntityKeyDefinitionsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::CountEntityKeyDefinitionsParams }, optional: false, nullable: false
      end
    end
  end
end
