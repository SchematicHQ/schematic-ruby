# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class ListEntityKeyDefinitionsParams < Internal::Types::Model
        field :entity_type, -> { Schematic::Types::EntityType }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
