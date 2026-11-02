# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogConfigOrderedEntitlement < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false

      field :visible, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
