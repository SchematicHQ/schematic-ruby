# frozen_string_literal: true

module Schematic
  module Types
    class EntityKeyDetailResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :definition, -> { Schematic::Types::EntityKeyDefinitionResponseData }, optional: true, nullable: false
      field :definition_id, -> { String }, optional: false, nullable: false
      field :entity_id, -> { String }, optional: false, nullable: false
      field :entity_type, -> { Schematic::Types::EntityType }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
