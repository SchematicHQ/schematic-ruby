# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CreateEntityTraitDefinitionRequestBody < Internal::Types::Model
        field :display_name, -> { String }, optional: true, nullable: false
        field :entity_type, -> { Schematic::Types::EntityType }, optional: false, nullable: false
        field :hierarchy, -> { Internal::Types::Array[String] }, optional: false, nullable: false
        field :trait_type, -> { Schematic::Types::TraitType }, optional: false, nullable: false
      end
    end
  end
end
