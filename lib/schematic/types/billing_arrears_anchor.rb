# frozen_string_literal: true

module Schematic
  module Types
    module BillingArrearsAnchor
      extend Schematic::Internal::Types::Enum

      BILLING_PERIOD_START = "billing_period_start"
      MONTH_END = "month_end"
    end
  end
end
