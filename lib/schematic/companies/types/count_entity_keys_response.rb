# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountEntityKeysResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::CountEntityKeysParams }, optional: false, nullable: false
      end
    end
  end
end
