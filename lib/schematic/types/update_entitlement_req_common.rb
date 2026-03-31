# frozen_string_literal: true

module Schematic
  module Types
    class UpdateEntitlementReqCommon < Internal::Types::Model
      field :credit_consumption_rate, -> { Integer }, optional: true, nullable: false
      field :metric_period, -> { Schematic::Types::UpdateEntitlementReqCommonMetricPeriod }, optional: true, nullable: false
      field :metric_period_month_reset, -> { Schematic::Types::UpdateEntitlementReqCommonMetricPeriodMonthReset }, optional: true, nullable: false
      field :value_bool, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :value_credit_id, -> { String }, optional: true, nullable: false
      field :value_numeric, -> { Integer }, optional: true, nullable: false
      field :value_trait_id, -> { String }, optional: true, nullable: false
      field :value_type, -> { Schematic::Types::EntitlementValueType }, optional: false, nullable: false
    end
  end
end
