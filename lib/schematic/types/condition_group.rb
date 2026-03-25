# frozen_string_literal: true

module Schematic
  module Types
    class ConditionGroup < Internal::Types::Model
      field :conditions, -> { Internal::Types::Array[Schematic::Types::Condition] }, optional: false, nullable: false
    end
  end
end
