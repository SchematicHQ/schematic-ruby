# frozen_string_literal: true

module Schematic
  module Types
    class BillingProductPricing < Internal::Types::Model
      field :billing_threshold, -> { Integer }, optional: true, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :meter_id, -> { String }, optional: true, nullable: false
      field :package_size, -> { Integer }, optional: true, nullable: false
      field :price, -> { Integer }, optional: false, nullable: false
      field :price_decimal, -> { String }, optional: true, nullable: false
      field :price_external_id, -> { String }, optional: false, nullable: false
      field :product_external_id, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :subscription_item_external_id, -> { String }, optional: true, nullable: false
      field :usage_type, -> { Schematic::Types::BillingPriceUsageType }, optional: false, nullable: false
    end
  end
end
