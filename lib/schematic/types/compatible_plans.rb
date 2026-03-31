# frozen_string_literal: true

module Schematic
  module Types
    class CompatiblePlans < Internal::Types::Model
      field :compatible_plan_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :source_plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
