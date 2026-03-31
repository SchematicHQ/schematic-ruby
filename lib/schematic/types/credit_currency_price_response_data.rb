# frozen_string_literal: true

module Schematic
  module Types
    class CreditCurrencyPriceResponseData < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :price, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
    end
  end
end
