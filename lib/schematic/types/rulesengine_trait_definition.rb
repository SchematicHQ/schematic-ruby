# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineTraitDefinition < Internal::Types::Model
      field :comparable_type, -> { Schematic::Types::RulesengineTraitDefinitionComparableType }, optional: false, nullable: false
      field :entity_type, -> { Schematic::Types::RulesengineEntityType }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
    end
  end
end
