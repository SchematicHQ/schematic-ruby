# frozen_string_literal: true

module Schematic
  module Types
    class CreditEventLedgerResponseData < Internal::Types::Model
      field :amount, -> { Float }, optional: false, nullable: false

      field :auto_topup_log_id, -> { String }, optional: true, nullable: false

      field :billing_credit_bundle_id, -> { String }, optional: true, nullable: false

      field :billing_credit_id, -> { String }, optional: true, nullable: false

      field :burn_breakdown, -> { Internal::Types::Array[Schematic::Types::CreditBurnBreakdownLine] }, optional: true, nullable: false

      field :company, -> { Schematic::Types::CompanyLedgerResponseData }, optional: true, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :credit, -> { Schematic::Types::BillingCreditLedgerResponseData }, optional: true, nullable: false

      field :credit_name, -> { String }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :environment_id, -> { String }, optional: false, nullable: false

      field :event_at, -> { String }, optional: false, nullable: false

      field :event_id, -> { String }, optional: false, nullable: false

      field :event_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :event_type, -> { Schematic::Types::CreditEventType }, optional: false, nullable: false

      field :expiry_type, -> { Schematic::Types::BillingCreditExpiryType }, optional: true, nullable: false

      field :expiry_unit, -> { Schematic::Types::BillingCreditExpiryUnit }, optional: true, nullable: false

      field :expiry_unit_count, -> { Integer }, optional: true, nullable: false

      field :feature, -> { Schematic::Types::FeatureLedgerResponseData }, optional: true, nullable: false

      field :feature_id, -> { String }, optional: true, nullable: false

      field :from_grant_id, -> { String }, optional: true, nullable: false

      field :grant_expires_at, -> { String }, optional: true, nullable: false

      field :grant_id, -> { String }, optional: true, nullable: false

      field :grant_quantity, -> { Float }, optional: true, nullable: false

      field :grant_quantity_remaining, -> { Float }, optional: true, nullable: false

      field :grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: true, nullable: false

      field :grant_valid_from, -> { String }, optional: true, nullable: false

      field :kind, -> { Schematic::Types::CreditLedgerEntryKind }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :quantity_consumed, -> { Float }, optional: true, nullable: false

      field :quantity_remaining_at_zero_out, -> { Float }, optional: true, nullable: false

      field :source_id, -> { Integer }, optional: false, nullable: false

      field :to_grant_id, -> { String }, optional: true, nullable: false

      field :transfer_reason, -> { Schematic::Types::CreditTransferReason }, optional: true, nullable: false

      field :usage_event_id, -> { String }, optional: true, nullable: false

      field :usage_reason, -> { Schematic::Types::CreditUsageReason }, optional: true, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false

      field :zeroed_out_reason, -> { Schematic::Types::BillingCreditGrantZeroedOutReason }, optional: true, nullable: false
    end
  end
end
