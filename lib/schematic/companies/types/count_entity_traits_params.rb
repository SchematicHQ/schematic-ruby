# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      # Input parameters
      class CountEntityTraitsParams < Internal::Types::Model
        field :definition_id, -> { String }, optional: true, nullable: false

        field :entity_type, -> { Schematic::Types::EntityType }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
