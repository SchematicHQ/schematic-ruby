# frozen_string_literal: true

module Schematic
  module Types
    class UpdateBillingPlanCreditGrantRequestBody < Internal::Types::Model
      field :apply_to_existing, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :auto_topup_amount, -> { Integer }, optional: true, nullable: false
      field :auto_topup_amount_type, -> { String }, optional: true, nullable: false
      field :auto_topup_enabled, -> { Internal::Types::Boolean }, optional: true, nullable: false
      field :auto_topup_expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :auto_topup_expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :auto_topup_expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :auto_topup_threshold_percent, -> { Integer }, optional: true, nullable: false
      field :credit_amount, -> { Integer }, optional: true, nullable: false
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :reset_cadence, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: false, nullable: false
      field :reset_start, -> { Schematic::Types::BillingPlanCreditGrantResetStart }, optional: false, nullable: false
      field :reset_type, -> { Schematic::Types::BillingPlanCreditGrantResetType }, optional: true, nullable: false
    end
  end
end
