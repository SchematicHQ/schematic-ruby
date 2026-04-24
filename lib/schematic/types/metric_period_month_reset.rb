# frozen_string_literal: true

module Schematic
  module Types
    module MetricPeriodMonthReset
      extend Schematic::Internal::Types::Enum

      BILLING_CYCLE = "billing_cycle"
      FIRST_OF_MONTH = "first_of_month"
    end
  end
end
