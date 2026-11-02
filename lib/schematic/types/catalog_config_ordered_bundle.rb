# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogConfigOrderedBundle < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false
    end
  end
end
