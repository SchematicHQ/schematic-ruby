# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListEntityKeyDefinitionsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::EntityKeyDefinitionResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListEntityKeyDefinitionsParams }, optional: false, nullable: false
      end
    end
  end
end
