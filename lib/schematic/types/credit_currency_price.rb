# frozen_string_literal: true

module Schematic
  module Types
    class CreditCurrencyPrice < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
