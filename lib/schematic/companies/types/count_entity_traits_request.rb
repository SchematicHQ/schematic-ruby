# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CountEntityTraitsRequest < Internal::Types::Model
        field :definition_id, -> { String }, optional: true, nullable: false
        field :entity_type, -> { Schematic::Types::EntityType }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
