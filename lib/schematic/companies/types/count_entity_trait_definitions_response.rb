# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class CountEntityTraitDefinitionsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::CountEntityTraitDefinitionsParams }, optional: false, nullable: false
      end
    end
  end
end
