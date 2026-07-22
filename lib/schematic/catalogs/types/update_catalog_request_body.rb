# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class UpdateCatalogRequestBody < Internal::Types::Model
        field :catalog_id, -> { String }, optional: false, nullable: false
        field :description, -> { String }, optional: true, nullable: false
        field :is_default, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
      end
    end
  end
end
