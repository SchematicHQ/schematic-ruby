# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class BindCatalogRequestBody < Internal::Types::Model
        field :component_id, -> { String }, optional: false, nullable: false
        field :catalog_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
