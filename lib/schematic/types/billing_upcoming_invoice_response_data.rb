# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingUpcomingInvoiceResponseData < Internal::Types::Model
      field :amount_due, -> { Integer }, optional: false, nullable: false

      field :at, -> { String }, optional: false, nullable: false

      field :change_id, -> { String }, optional: true, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :discount, -> { Integer }, optional: false, nullable: false

      field :due_at, -> { String }, optional: true, nullable: false

      field :ending_balance, -> { Integer }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::BillingStatementLineResponseData] }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false

      field :starting_balance, -> { Integer }, optional: false, nullable: false

      field :subscription_external_id, -> { String }, optional: true, nullable: false

      field :subscription_id, -> { String }, optional: true, nullable: false

      field :subtotal, -> { Integer }, optional: false, nullable: false

      field :tax, -> { Integer }, optional: false, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false
    end
  end
end
