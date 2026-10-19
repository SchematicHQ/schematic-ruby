# frozen_string_literal: true

module Schematic
  module Types
    class PreflightEventQuantitiesRequestBody < Internal::Types::Model
      field :event_subtype, -> { String }, optional: false, nullable: false

      field :quantities, -> { Internal::Types::Hash[String, Float] }, optional: true, nullable: false

      field :quantity, -> { Float }, optional: true, nullable: false
    end
  end
end
