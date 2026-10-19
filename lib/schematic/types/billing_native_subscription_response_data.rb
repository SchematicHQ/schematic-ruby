# frozen_string_literal: true

module Schematic
  module Types
    class BillingNativeSubscriptionResponseData < Internal::Types::Model
      field :cancel_at, -> { String }, optional: true, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::BillingNativeSubscriptionLineResponseData] }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :scheduled_changes, -> { Internal::Types::Array[Schematic::Types::BillingNativeSubscriptionChangeResponseData] }, optional: false, nullable: false

      field :started_at, -> { String }, optional: true, nullable: false

      field :statement, -> { Schematic::Types::BillingStatementResponseData }, optional: true, nullable: false

      field :status, -> { Schematic::Types::SubscriptionStatus }, optional: false, nullable: false

      field :terms, -> { Schematic::Types::BillingInvoiceTermsResponseData }, optional: true, nullable: false
    end
  end
end
