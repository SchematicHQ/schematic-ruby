# frozen_string_literal: true

module Schematic
  module Types
    class CreditCompanyGrantView < Internal::Types::Model
      field :billing_credit_bundle_id, -> { String }, optional: true, nullable: false
      field :billing_credit_id, -> { String }, optional: false, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :company_name, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :credit_description, -> { String }, optional: false, nullable: false
      field :credit_icon, -> { String }, optional: true, nullable: false
      field :credit_name, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :exhausted_at, -> { String }, optional: true, nullable: false
      field :expires_at, -> { String }, optional: true, nullable: false
      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false
      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false
      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false
      field :grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :plan_id, -> { String }, optional: true, nullable: false
      field :plan_name, -> { String }, optional: true, nullable: false
      field :plural_name, -> { String }, optional: true, nullable: false
      field :price, -> { Schematic::Types::BillingProductPriceResponseData }, optional: true, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :quantity_remaining, -> { Integer }, optional: false, nullable: false
      field :quantity_used, -> { Integer }, optional: false, nullable: false
      field :renewal_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :renewal_period, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: true, nullable: false
      field :singular_name, -> { String }, optional: true, nullable: false
      field :source_label, -> { String }, optional: false, nullable: false
      field :transfers, -> { Internal::Types::Array[Schematic::Types::CreditTransferView] }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :valid_from, -> { String }, optional: true, nullable: false
      field :zeroed_out_date, -> { String }, optional: true, nullable: false
      field :zeroed_out_reason, -> { Schematic::Types::BillingCreditGrantZeroedOutReason }, optional: true, nullable: false
    end
  end
end
