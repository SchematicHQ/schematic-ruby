# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogPlanIDsResponseData < Internal::Types::Model
      field :plan_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
