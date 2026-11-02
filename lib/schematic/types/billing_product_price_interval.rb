# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingProductPriceInterval
      extend Schematic::Internal::Types::Enum

      DAY = "day"
      MONTH = "month"
      ONE_TIME = "one-time"
      YEAR = "year"
    end
  end
end
