# frozen_string_literal: true

module Schematic
  module Types
    class CreditGrantExpiryRequestBody < Internal::Types::Model
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :reset_cadence, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: false, nullable: false
      field :reset_start, -> { Schematic::Types::BillingPlanCreditGrantResetStart }, optional: false, nullable: false
      field :reset_type, -> { Schematic::Types::BillingPlanCreditGrantResetType }, optional: true, nullable: false
    end
  end
end
