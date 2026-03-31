# frozen_string_literal: true

module Schematic
  module Types
    class EntitlementCurrencyPricesResponseData < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :monthly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
      field :yearly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
