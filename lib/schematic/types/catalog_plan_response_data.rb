# frozen_string_literal: true

module Schematic
  module Types
    class CatalogPlanResponseData < Internal::Types::Model
      field :available_periods, -> { Internal::Types::Array[Schematic::Types::PlanPriceCadence] }, optional: false, nullable: false

      field :billing_strategy, -> { Schematic::Types::BillingStrategy }, optional: false, nullable: false

      field :charge_type, -> { Schematic::Types::ChargeType }, optional: false, nullable: false

      field :compatible_plan_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::CatalogCurrencyPricesResponseData] }, optional: false, nullable: false

      field :description, -> { String }, optional: false, nullable: false

      field :entitlements, -> { Internal::Types::Array[Schematic::Types::CatalogPlanEntitlementResponseData] }, optional: false, nullable: false

      field :icon, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :included_credit_grants, -> { Internal::Types::Array[Schematic::Types::CatalogCreditGrantResponseData] }, optional: false, nullable: false

      field :is_trialable, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :monthly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :one_time_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :quarterly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :trial_days, -> { Integer }, optional: true, nullable: false

      field :yearly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false
    end
  end
end
