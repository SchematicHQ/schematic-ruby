# frozen_string_literal: true

module Schematic
  module Types
    class RulesengineConditionGroup < Internal::Types::Model
      field :conditions, -> { Internal::Types::Array[Schematic::Types::RulesengineCondition] }, optional: false, nullable: false
    end
  end
end
