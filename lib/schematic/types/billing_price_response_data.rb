# frozen_string_literal: true

module Schematic
  module Types
    class BillingPriceResponseData < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :external_price_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :interval, -> { Schematic::Types::BillingProductPriceInterval }, optional: false, nullable: false
      field :nickname, -> { String }, optional: true, nullable: false
      field :price, -> { Integer }, optional: false, nullable: false
      field :price_decimal, -> { String }, optional: true, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :scheme, -> { Schematic::Types::BillingPriceScheme }, optional: false, nullable: false
    end
  end
end
