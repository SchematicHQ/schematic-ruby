# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineTrait < Internal::Types::Model
      field :trait_definition, -> { Schematic::Types::RulesengineTraitDefinition }, optional: true, nullable: false
      field :value, -> { String }, optional: false, nullable: false
    end
  end
end
