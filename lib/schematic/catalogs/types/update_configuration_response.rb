# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class UpdateConfigurationResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CatalogResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
