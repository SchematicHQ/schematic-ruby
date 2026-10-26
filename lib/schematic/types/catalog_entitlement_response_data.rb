# frozen_string_literal: true

module Schematic
  module Types
    class CatalogEntitlementResponseData < Internal::Types::Model
      field :consumption_rate, -> { Float }, optional: true, nullable: false

      field :credit_equivalent_limit, -> { Integer }, optional: true, nullable: false

      field :credit_icon, -> { String }, optional: true, nullable: false

      field :credit_id, -> { String }, optional: true, nullable: false

      field :credit_name, -> { String }, optional: true, nullable: false

      field :credit_plural_name, -> { String }, optional: true, nullable: false

      field :credit_singular_name, -> { String }, optional: true, nullable: false

      field :currency_prices, -> { Internal::Types::Array[Schematic::Types::CatalogCurrencyPricesResponseData] }, optional: false, nullable: false

      field :feature_description, -> { String }, optional: false, nullable: false

      field :feature_icon, -> { String }, optional: false, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :feature_name, -> { String }, optional: false, nullable: false

      field :feature_plural_name, -> { String }, optional: true, nullable: false

      field :feature_singular_name, -> { String }, optional: true, nullable: false

      field :feature_type, -> { Schematic::Types::FeatureType }, optional: false, nullable: false

      field :license_id, -> { String }, optional: true, nullable: false

      field :metered_monthly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :metered_quarterly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :metered_yearly_price, -> { Schematic::Types::CatalogPriceResponseData }, optional: true, nullable: false

      field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false

      field :metric_period_month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false

      field :price_behavior, -> { Schematic::Types::EntitlementPriceBehavior }, optional: true, nullable: false

      field :soft_limit, -> { Integer }, optional: true, nullable: false

      field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false

      field :value_numeric, -> { Integer }, optional: true, nullable: false

      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false

      field :warning_threshold, -> { Integer }, optional: true, nullable: false
    end
  end
end
