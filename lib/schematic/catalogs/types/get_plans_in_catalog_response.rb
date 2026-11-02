# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Catalogs
    module Types
      class GetPlansInCatalogResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CatalogPlanIDsResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
