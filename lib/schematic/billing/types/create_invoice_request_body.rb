# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class CreateInvoiceRequestBody < Internal::Types::Model
        field :amount_due, -> { Integer }, optional: false, nullable: false
        field :amount_paid, -> { Integer }, optional: false, nullable: false
        field :amount_remaining, -> { Integer }, optional: false, nullable: false
        field :collection_method, -> { String }, optional: false, nullable: false
        field :currency, -> { String }, optional: false, nullable: false
        field :customer_external_id, -> { String }, optional: false, nullable: false
        field :due_date, -> { String }, optional: true, nullable: false
        field :external_id, -> { String }, optional: true, nullable: false
        field :payment_method_external_id, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::InvoiceStatus }, optional: true, nullable: false
        field :subscription_external_id, -> { String }, optional: true, nullable: false
        field :subtotal, -> { Integer }, optional: false, nullable: false
        field :url, -> { String }, optional: true, nullable: false
      end
    end
  end
end
