# frozen_string_literal: true

module Schematic
  module Types
    class UpdateRuleRequestBody < Internal::Types::Model
      field :condition_groups, -> { Internal::Types::Array[Schematic::Types::CreateOrUpdateConditionGroupRequestBody] }, optional: false, nullable: false
      field :conditions, -> { Internal::Types::Array[Schematic::Types::CreateOrUpdateConditionRequestBody] }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :priority, -> { Integer }, optional: false, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
