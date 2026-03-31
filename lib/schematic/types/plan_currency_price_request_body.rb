# frozen_string_literal: true

module Schematic
  module Types
    class PlanCurrencyPriceRequestBody < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :monthly_price, -> { Integer }, optional: true, nullable: false
      field :one_time_price, -> { Integer }, optional: true, nullable: false
      field :yearly_price, -> { Integer }, optional: true, nullable: false
    end
  end
end
