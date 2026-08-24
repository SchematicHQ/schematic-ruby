# frozen_string_literal: true

module Schematic
  module Catalogs
    module Types
      class GetConfigurationResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CatalogConfigurationResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
