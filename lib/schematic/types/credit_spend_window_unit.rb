# frozen_string_literal: true

require_relative "../../schematic"

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
