# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Catalogs
    module Types
      class ListCatalogsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CatalogResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Catalogs::Types::ListCatalogsParams }, optional: false, nullable: false
      end
    end
  end
end
