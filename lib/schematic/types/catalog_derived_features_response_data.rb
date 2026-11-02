# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogDerivedFeaturesResponseData < Internal::Types::Model
      field :features, -> { Internal::Types::Array[Schematic::Types::CatalogDerivedFeatureResponseData] }, optional: false, nullable: false
    end
  end
end
