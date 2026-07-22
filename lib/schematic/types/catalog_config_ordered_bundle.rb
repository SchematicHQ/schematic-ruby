# frozen_string_literal: true

module Schematic
  module Types
    class CatalogConfigOrderedBundle < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false
    end
  end
end
