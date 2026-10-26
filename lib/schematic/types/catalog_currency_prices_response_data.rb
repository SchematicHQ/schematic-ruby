# frozen_string_literal: true

module Schematic
  module Types
    class CatalogCurrencyPricesResponseData < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :monthly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :one_time_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :quarterly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :yearly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false
    end
  end
end
