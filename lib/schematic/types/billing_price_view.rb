# frozen_string_literal: true

module Schematic
  module Types
    class BillingPriceView < Internal::Types::Model
      field :billing_scheme, -> { Schematic::Types::BillingPriceScheme }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :interval, -> { Schematic::Types::BillingProductPriceInterval }, optional: false, nullable: false
      field :is_active, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :meter_event_name, -> { String }, optional: true, nullable: false
      field :meter_event_payload_key, -> { String }, optional: true, nullable: false
      field :meter_id, -> { String }, optional: true, nullable: false
      field :nickname, -> { String }, optional: true, nullable: false
      field :package_size, -> { Integer }, optional: false, nullable: false
      field :price, -> { Integer }, optional: false, nullable: false
      field :price_decimal, -> { String }, optional: true, nullable: false
      field :price_external_id, -> { String }, optional: false, nullable: false
      field :price_id, -> { String }, optional: false, nullable: false
      field :price_tier, -> { Internal::Types::Array[Schematic::Types::BillingProductPriceTierResponseData] }, optional: false, nullable: false
      field :product_external_id, -> { String }, optional: false, nullable: false
      field :product_id, -> { String }, optional: false, nullable: false
      field :product_name, -> { String }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :tiers_mode, -> { Schematic::Types::BillingTiersMode }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :usage_type, -> { Schematic::Types::BillingPriceUsageType }, optional: false, nullable: false
    end
  end
end
