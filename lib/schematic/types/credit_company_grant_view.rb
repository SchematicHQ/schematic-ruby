# frozen_string_literal: true

module Schematic
  module Types
    class CreditCompanyGrantView < Internal::Types::Model
      field :arrears_cadence, -> { Schematic::Types::BillingArrearsCadence }, optional: true, nullable: false

      field :billing_credit_bundle_id, -> { String }, optional: true, nullable: false

      field :billing_credit_id, -> { String }, optional: false, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :company_license_id, -> { String }, optional: true, nullable: false

      field :company_name, -> { String }, optional: false, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :credit_description, -> { String }, optional: false, nullable: false

      field :credit_icon, -> { String }, optional: true, nullable: false

      field :credit_name, -> { String }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :exhausted_at, -> { String }, optional: true, nullable: false

      field :expires_at, -> { String }, optional: true, nullable: false

      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false

      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false

      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false

      field :grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :license_name, -> { String }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :plan_name, -> { String }, optional: true, nullable: false

      field :plural_name, -> { String }, optional: true, nullable: false

      field :postpaid_charge_amount, -> { Integer }, optional: true, nullable: false

      field :postpaid_charge_currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :postpaid_charged_credits, -> { Float }, optional: true, nullable: false

      field :postpaid_period_end, -> { String }, optional: true, nullable: false

      field :postpaid_rate, -> { Integer }, optional: true, nullable: false

      field :postpaid_rate_decimal, -> { String }, optional: true, nullable: false

      field :price, -> { Schematic::Types::BillingProductPriceResponseData }, optional: true, nullable: false

      field :quantity, -> { Float }, optional: false, nullable: false

      field :quantity_remaining, -> { Float }, optional: false, nullable: false

      field :quantity_used, -> { Float }, optional: false, nullable: false

      field :renewal_enabled, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :renewal_period, -> { Schematic::Types::BillingPlanCreditGrantResetCadence }, optional: true, nullable: false

      field :reserved, -> { Float }, optional: true, nullable: false

      field :settled, -> { Float }, optional: true, nullable: false

      field :singular_name, -> { String }, optional: true, nullable: false

      field :source_grant_id, -> { String }, optional: true, nullable: false

      field :source_label, -> { String }, optional: false, nullable: false

      field :transfers, -> { Internal::Types::Array[Schematic::Types::CreditTransferView] }, optional: true, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false

      field :valid_from, -> { String }, optional: true, nullable: false

      field :zeroed_out_date, -> { String }, optional: true, nullable: false

      field :zeroed_out_reason, -> { Schematic::Types::BillingCreditGrantZeroedOutReason }, optional: true, nullable: false
    end
  end
end
