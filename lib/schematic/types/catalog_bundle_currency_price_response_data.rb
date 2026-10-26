# frozen_string_literal: true

module Schematic
  module Types
    class CatalogBundleCurrencyPriceResponseData < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :unit_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false
    end
  end
end
