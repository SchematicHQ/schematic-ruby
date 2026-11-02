# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingInvoiceWebhook < Internal::Types::Model
      field :amount_due, -> { Integer }, optional: false, nullable: false

      field :amount_paid, -> { Integer }, optional: false, nullable: false

      field :amount_remaining, -> { Integer }, optional: false, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :contract_id, -> { String }, optional: true, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :due_date, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :number, -> { String }, optional: true, nullable: false

      field :period_end, -> { String }, optional: true, nullable: false

      field :period_start, -> { String }, optional: true, nullable: false

      field :status, -> { Schematic::Types::InvoiceStatus }, optional: true, nullable: false

      field :subtotal, -> { Integer }, optional: false, nullable: false

      field :tax, -> { Integer }, optional: false, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false

      field :url, -> { String }, optional: true, nullable: false
    end
  end
end
