# frozen_string_literal: true

module Schematic
  module Types
    module CreditSpendWindowUnit
      extend Schematic::Internal::Types::Enum

      HOUR = "hour"
      DAY = "day"
      WEEK = "week"
      MONTH = "month"
      BILLING_PERIOD = "billing_period"
    end
  end
end
