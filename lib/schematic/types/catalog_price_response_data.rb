# frozen_string_literal: true

module Schematic
  module Types
    class CatalogPriceResponseData < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :interval, -> { Schematic::Types::BillingProductPriceInterval }, optional: false, nullable: false

      field :interval_count, -> { Integer }, optional: false, nullable: false

      field :overage_unit_price_decimal, -> { String }, optional: true, nullable: false

      field :package_size, -> { Integer }, optional: false, nullable: false

      field :price, -> { Integer }, optional: false, nullable: false

      field :price_decimal, -> { String }, optional: true, nullable: false

      field :price_tiers, -> { Internal::Types::Array[Schematic::Types::CatalogPriceTierResponseData] }, optional: false, nullable: false

      field :scheme, -> { Schematic::Types::BillingPriceScheme }, optional: false, nullable: false

      field :tiers_mode, -> { Schematic::Types::BillingTiersMode }, optional: true, nullable: false
    end
  end
end
