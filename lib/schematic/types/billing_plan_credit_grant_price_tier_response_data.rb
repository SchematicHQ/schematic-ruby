# frozen_string_literal: true

module Schematic
  module Types
    class BillingPlanCreditGrantPriceTierResponseData < Internal::Types::Model
      field :from, -> { Integer }, optional: false, nullable: false

      field :per_unit_price, -> { Integer }, optional: true, nullable: false

      field :per_unit_price_decimal, -> { String }, optional: true, nullable: false

      field :to, -> { Integer }, optional: true, nullable: false
    end
  end
end
