# frozen_string_literal: true

module Schematic
  module Types
    class PlanCurrencyPricesResponseData < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :monthly_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :one_time_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
      field :yearly_price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
    end
  end
end
