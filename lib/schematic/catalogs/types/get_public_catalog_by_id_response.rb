# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class GetPublicCatalogByIdResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PublicCatalogResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
