# frozen_string_literal: true

module Schematic
  module Types
    class BillingProductForSubscriptionResponseData < Internal::Types::Model
      field :billing_scheme, -> { Schematic::Types::BillingPriceScheme }, optional: false, nullable: false
      field :billing_threshold, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :meter_id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :package_size, -> { Integer }, optional: false, nullable: false
      field :price, -> { Integer }, optional: false, nullable: false
      field :price_decimal, -> { String }, optional: true, nullable: false
      field :price_external_id, -> { String }, optional: false, nullable: false
      field :price_id, -> { String }, optional: false, nullable: false
      field :price_tier, -> { Internal::Types::Array[Schematic::Types::BillingProductPriceTierResponseData] }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :subscription_id, -> { String }, optional: false, nullable: false
      field :subscription_item_external_id, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :usage_type, -> { Schematic::Types::BillingPriceUsageType }, optional: false, nullable: false
    end
  end
end
