# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompatiblePlansResponseData < Internal::Types::Model
      field :compatible_plan_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :source_plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
