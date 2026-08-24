# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class CreateCatalogRequestBody < Internal::Types::Model
        field :description, -> { String }, optional: true, nullable: false

        field :name, -> { String }, optional: false, nullable: false
      end
    end
  end
end
