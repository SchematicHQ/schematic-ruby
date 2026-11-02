# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EntitlementCurrencyPricesResponseData < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :monthly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false

      field :quarterly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false

      field :yearly_price, -> { Schematic::Types::BillingPriceView }, optional: true, nullable: false
    end
  end
end
