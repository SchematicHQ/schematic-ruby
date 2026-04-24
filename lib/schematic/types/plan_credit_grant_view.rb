# frozen_string_literal: true

module Schematic
  module Types
    class PlanCreditGrantView < Internal::Types::Model
      field :billing_credit_auto_topup_amount, -> { Integer }, optional: true, nullable: false
      field :billing_credit_auto_topup_amount_type, -> { String }, optional: true, nullable: false
      field :billing_credit_auto_topup_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :billing_credit_auto_topup_expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :billing_credit_auto_topup_expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :billing_credit_auto_topup_expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :billing_credit_auto_topup_threshold_credits, -> { Integer }, optional: true, nullable: false
      field :billing_credit_auto_topup_threshold_percent, -> { Integer }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit, -> { Schematic::Types::BillingCreditView }, optional: true, nullable: false
      field :credit_amount, -> { Integer }, optional: false, nullable: false
      field :credit_description, -> { String }, optional: false, nullable: false
      field :credit_icon, -> { String }, optional: true, nullable: false
      field :credit_id, -> { String }, optional: false, nullable: false
      field :credit_name, -> { String }, optional: false, nullable: false
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :plan, -> { Schematic::Types::GenericPreviewObject }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :plan_version_id, -> { String }, optional: true, nullable: false
      field :plural_name, -> { String }, optional: true, nullable: false
      field :reset_cadence, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: true, nullable: false
      field :reset_start, -> { Schematic::Types::BillingPlanCreditGrantResetStart }, optional: true, nullable: false
      field :reset_type, -> { Schematic::Types::BillingPlanCreditGrantResetType }, optional: false, nullable: false
      field :singular_name, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
