# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListEntityTraitDefinitionsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EntityTraitDefinitionResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListEntityTraitDefinitionsParams }, optional: false, nullable: false
      end
    end
  end
end
