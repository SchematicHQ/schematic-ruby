# frozen_string_literal: true

module Schematic
  module Types
    class UpsertBillingProductRequestBody < Internal::Types::Model
      field :billing_product_id, -> { String }, optional: true, nullable: false
      field :charge_type, -> { Schematic::Types::ChargeType }, optional: false, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::PlanCurrencyPriceRequestBody] }, optional: true, nullable: false
      field :is_trialable, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :monthly_price, -> { Integer }, optional: true, nullable: false
      field :monthly_price_id, -> { String }, optional: true, nullable: false
      field :one_time_price, -> { Integer }, optional: true, nullable: false
      field :one_time_price_id, -> { String }, optional: true, nullable: false
      field :trial_days, -> { Integer }, optional: true, nullable: false
      field :yearly_price, -> { Integer }, optional: true, nullable: false
      field :yearly_price_id, -> { String }, optional: true, nullable: false
    end
  end
end
