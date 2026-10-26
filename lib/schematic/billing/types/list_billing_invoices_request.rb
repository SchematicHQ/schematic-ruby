# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListBillingInvoicesRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false

        field :contract_id, -> { String }, optional: true, nullable: false

        field :document_state, -> { Schematic::Types::InvoiceDocumentState }, optional: true, nullable: false

        field :past_due, -> { Internal::Types::Boolean }, optional: true, nullable: false

        field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: true, nullable: false

        field :q, -> { String }, optional: true, nullable: false

        field :status, -> { Schematic::Types::InvoiceStatus }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
