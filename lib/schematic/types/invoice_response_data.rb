# frozen_string_literal: true

module Schematic
  module Types
    class InvoiceResponseData < Internal::Types::Model
      field :amount_due, -> { Integer }, optional: false, nullable: false
      field :amount_paid, -> { Integer }, optional: false, nullable: false
      field :amount_remaining, -> { Integer }, optional: false, nullable: false
      field :collection_method, -> { String }, optional: false, nullable: false
      field :company_id, -> { String }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :customer_external_id, -> { String }, optional: false, nullable: false
      field :due_date, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :payment_method_external_id, -> { String }, optional: true, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :status, -> { Schematic::Types::InvoiceStatus }, optional: true, nullable: false
      field :subscription_external_id, -> { String }, optional: true, nullable: false
      field :subtotal, -> { Integer }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :url, -> { String }, optional: true, nullable: false
    end
  end
end
