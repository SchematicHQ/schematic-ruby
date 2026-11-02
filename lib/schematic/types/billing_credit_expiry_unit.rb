# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingCreditExpiryUnit
      extend Schematic::Internal::Types::Enum

      BILLING_PERIODS = "billing_periods"
      DAYS = "days"
    end
  end
end
