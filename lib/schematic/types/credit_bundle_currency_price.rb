# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CreditBundleCurrencyPrice < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
