# frozen_string_literal: true

module Schematic
  module Types
    class EntityTraitDefinitionResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :display_name, -> { String }, optional: false, nullable: false
      field :entity_type, -> { Schematic::Types::EntityType }, optional: false, nullable: false
      field :hierarchy, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :trait_type, -> { Schematic::Types::TraitType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
