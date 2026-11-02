# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogConfigOrderedEntitlementResponseData < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false

      field :visible, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
