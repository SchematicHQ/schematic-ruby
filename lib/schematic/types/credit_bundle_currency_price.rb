# frozen_string_literal: true

module Schematic
  module Types
    class CreditBundleCurrencyPrice < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
