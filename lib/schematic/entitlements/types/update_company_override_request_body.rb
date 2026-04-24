# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class UpdateCompanyOverrideRequestBody < Internal::Types::Model
        field :company_override_id, -> { String }, optional: false, nullable: false
        field :credit_consumption_rate, -> { Integer }, optional: true, nullable: false
        field :expiration_date, -> { String }, optional: true, nullable: false
        field :metric_period, -> { Schematic::Types::MetricPeriod }, optional: true, nullable: false
        field :metric_period_month_reset, -> { Schematic::Types::MetricPeriodMonthReset }, optional: true, nullable: false
        field :note, -> { String }, optional: true, nullable: false
        field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :value_credit_id, -> { String }, optional: true, nullable: false
        field :value_numeric, -> { Integer }, optional: true, nullable: false
        field :value_trait_id, -> { String }, optional: true, nullable: false
        field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
      end
    end
  end
end
