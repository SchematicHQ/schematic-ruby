# frozen_string_literal: true

module Schematic
  module Types
    class CatalogDerivedFeaturesResponseData < Internal::Types::Model
      field :features, -> { Internal::Types::Array[Schematic::Types::CatalogDerivedFeatureResponseData] }, optional: false, nullable: false
    end
  end
end
