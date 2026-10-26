# frozen_string_literal: true

module Schematic
  module Types
    class BillingInvoiceDetailResponseData < Internal::Types::Model
      field :amount_paid, -> { Integer }, optional: false, nullable: false

      field :amount_remaining, -> { Integer }, optional: false, nullable: false

      field :collection_state, -> { Schematic::Types::InvoiceCollectionState }, optional: true, nullable: false

      field :collector, -> { Schematic::Types::Collector }, optional: true, nullable: false

      field :company_id, -> { String }, optional: false, nullable: false

      field :contract_id, -> { String }, optional: true, nullable: false

      field :created_at, -> { String }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :discount, -> { Integer }, optional: false, nullable: false

      field :document_state, -> { Schematic::Types::InvoiceDocumentState }, optional: true, nullable: false

      field :due_at, -> { String }, optional: true, nullable: false

      field :external_id, -> { String }, optional: true, nullable: false

      field :finalized_at, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::BillingInvoiceLineResponseData] }, optional: false, nullable: false

      field :number, -> { String }, optional: true, nullable: false

      field :pdf_url, -> { String }, optional: true, nullable: false

      field :period_end, -> { String }, optional: true, nullable: false

      field :period_start, -> { String }, optional: true, nullable: false

      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false

      field :settlements, -> { Internal::Types::Array[Schematic::Types::BillingInvoiceSettlementResponseData] }, optional: false, nullable: false

      field :status, -> { Schematic::Types::InvoiceStatus }, optional: false, nullable: false

      field :subscription_external_id, -> { String }, optional: true, nullable: false

      field :subscription_id, -> { String }, optional: true, nullable: false

      field :subtotal, -> { Integer }, optional: false, nullable: false

      field :tax, -> { Integer }, optional: false, nullable: false

      field :terms, -> { Schematic::Types::BillingInvoiceTermsResponseData }, optional: true, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false

      field :url, -> { String }, optional: true, nullable: false
    end
  end
end
