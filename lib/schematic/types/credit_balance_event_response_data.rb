# frozen_string_literal: true

module Schematic
  module Types
    class CreditBalanceEventResponseData < Internal::Types::Model
      field :amount, -> { Float }, optional: false, nullable: false

      field :event_type, -> { Schematic::Types::CreditEventType }, optional: false, nullable: false

      field :grant_id, -> { String }, optional: true, nullable: false

      field :grant_reason, -> { Schematic::Types::BillingCreditGrantReason }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :timestamp, -> { String }, optional: false, nullable: false

      field :zeroed_out_reason, -> { Schematic::Types::BillingCreditGrantZeroedOutReason }, optional: true, nullable: false
    end
  end
end
