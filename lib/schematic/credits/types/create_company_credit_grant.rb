# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CreateCompanyCreditGrant < Internal::Types::Model
        field :billing_periods_count, -> { Integer }, optional: true, nullable: false
        field :company_id, -> { String }, optional: false, nullable: false
        field :credit_id, -> { String }, optional: false, nullable: false
        field :expires_at, -> { String }, optional: true, nullable: false
        field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
        field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
        field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
        field :quantity, -> { Integer }, optional: false, nullable: false
        field :reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: false, nullable: false
        field :renewal_enabled, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :renewal_period, -> { Schematic::Types::BillingPlanCreditGrantResetStart }, optional: true, nullable: false
      end
    end
  end
end
