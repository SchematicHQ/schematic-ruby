# frozen_string_literal: true

module Schematic
  module Types
    class EntityTraitValue < Internal::Types::Model
      field :definition_id, -> { String }, optional: false, nullable: false
      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
