# frozen_string_literal: true

module Schematic
  module Types
    class CreditLedgerEnrichedEntryResponseData < Internal::Types::Model
      field :billing_credit_auto_topup_grant_count, -> { Integer }, optional: false, nullable: false
      field :billing_credit_id, -> { String }, optional: false, nullable: false
      field :company, -> { Schematic::Types::CompanyLedgerResponseData }, optional: true, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :credit, -> { Schematic::Types::BillingCreditLedgerResponseData }, optional: true, nullable: false
      field :expired_grant_count, -> { Integer }, optional: false, nullable: false
      field :feature, -> { Schematic::Types::FeatureLedgerResponseData }, optional: true, nullable: false
      field :feature_id, -> { String }, optional: true, nullable: false
      field :first_transaction_at, -> { String }, optional: false, nullable: false
      field :free_grant_count, -> { Integer }, optional: false, nullable: false
      field :grant_count, -> { Integer }, optional: false, nullable: false
      field :last_transaction_at, -> { String }, optional: false, nullable: false
      field :manually_zeroed_count, -> { Integer }, optional: false, nullable: false
      field :net_change, -> { Integer }, optional: false, nullable: false
      field :plan_grant_count, -> { Integer }, optional: false, nullable: false
      field :purchased_grant_count, -> { Integer }, optional: false, nullable: false
      field :time_bucket, -> { String }, optional: false, nullable: false
      field :total_consumed, -> { Integer }, optional: false, nullable: false
      field :total_granted, -> { Integer }, optional: false, nullable: false
      field :transaction_count, -> { Integer }, optional: false, nullable: false
      field :usage_count, -> { Integer }, optional: false, nullable: false
      field :zeroed_out_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
