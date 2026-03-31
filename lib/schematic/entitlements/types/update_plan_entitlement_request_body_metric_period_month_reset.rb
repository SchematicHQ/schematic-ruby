# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      module UpdatePlanEntitlementRequestBodyMetricPeriodMonthReset
        extend Schematic::Internal::Types::Enum

        FIRST_OF_MONTH = "first_of_month"
        BILLING_CYCLE = "billing_cycle"
      end
    end
  end
end
