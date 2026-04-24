# frozen_string_literal: true

module Schematic
  module Types
    class BillingPlanCreditGrantResponseData < Internal::Types::Model
      field :auto_topup_amount, -> { Integer }, optional: true, nullable: false
      field :auto_topup_amount_type, -> { String }, optional: true, nullable: false
      field :auto_topup_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :auto_topup_expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :auto_topup_expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :auto_topup_expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :auto_topup_threshold_credits, -> { Integer }, optional: true, nullable: false
      field :auto_topup_threshold_percent, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit, -> { Schematic::Types::BillingCreditResponseData }, optional: true, nullable: false
      field :credit_amount, -> { Integer }, optional: false, nullable: false
      field :credit_id, -> { String }, optional: false, nullable: false
      field :credit_name, -> { String }, optional: false, nullable: false
      field :credit_plural_name, -> { String }, optional: true, nullable: false
      field :credit_singular_name, -> { String }, optional: true, nullable: false
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :plan, -> { Schematic::Types::PreviewObjectResponseData }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :plan_name, -> { String }, optional: false, nullable: false
      field :plan_version_id, -> { String }, optional: true, nullable: false
      field :reset_cadence, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: true, nullable: false
      field :reset_start, -> { Schematic::Types::BillingPlanCreditGrantResetStart }, optional: true, nullable: false
      field :reset_type, -> { Schematic::Types::BillingPlanCreditGrantResetType }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
