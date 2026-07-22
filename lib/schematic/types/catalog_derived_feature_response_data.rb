# frozen_string_literal: true

module Schematic
  module Types
    class CatalogDerivedFeatureResponseData < Internal::Types::Model
      field :icon, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
