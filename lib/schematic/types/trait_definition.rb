# frozen_string_literal: true

module Schematic
  module Types
    class TraitDefinition < Internal::Types::Model
      field :comparable_type, -> { Schematic::Types::TraitDefinitionComparableType }, optional: false, nullable: false
      field :entity_type, -> { Schematic::Types::EntityType }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
    end
  end
end
