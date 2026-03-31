# frozen_string_literal: true

module Schematic
  module Types
    class BillingProductDetailResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :is_active, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :price, -> { Integer }, optional: false, nullable: false
      field :price_decimal, -> { String }, optional: true, nullable: false
      field :prices, -> { Internal::Types::Array[Schematic::Types::BillingPriceResponseData] }, optional: false, nullable: false
      field :product_id, -> { String }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :subscription_count, -> { Integer }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
