# frozen_string_literal: true

module Schematic
  module Types
    class CreditUsageAggregation < Internal::Types::Model
      field :usage_this_billing_period, -> { Integer }, optional: true, nullable: false
      field :usage_this_calendar_month, -> { Integer }, optional: true, nullable: false
      field :usage_this_week, -> { Integer }, optional: true, nullable: false
      field :usage_today, -> { Integer }, optional: true, nullable: false
    end
  end
end
