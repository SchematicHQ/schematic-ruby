# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class UpdateEntityTraitDefinitionRequestBody < Internal::Types::Model
        field :entity_trait_definition_id, -> { String }, optional: false, nullable: false
        field :display_name, -> { String }, optional: true, nullable: false
        field :trait_type, -> { Schematic::Types::TraitType }, optional: false, nullable: false
      end
    end
  end
end
