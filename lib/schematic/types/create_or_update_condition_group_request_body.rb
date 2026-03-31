# frozen_string_literal: true

module Schematic
  module Types
    class CreateOrUpdateConditionGroupRequestBody < Internal::Types::Model
      field :conditions, -> { Internal::Types::Array[Schematic::Types::CreateOrUpdateConditionRequestBody] }, optional: false, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: true, nullable: false
    end
  end
end
