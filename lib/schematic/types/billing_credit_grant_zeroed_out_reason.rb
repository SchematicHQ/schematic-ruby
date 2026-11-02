# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingCreditGrantZeroedOutReason
      extend Schematic::Internal::Types::Enum

      CUSTOMER_ARCHIVED = "customer_archived"
      EXPIRED = "expired"
      INTEGRATION_UNINSTALLED = "integration_uninstalled"
      LICENSE_RETIRED = "license_retired"
      MANUAL = "manual"
      PLAN_CHANGE = "plan_change"
      PLAN_PERIOD_RESET = "plan_period_reset"
      RECONCILED = "reconciled"
    end
  end
end
