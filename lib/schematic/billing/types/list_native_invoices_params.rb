# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      # Input parameters
      class ListNativeInvoicesParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false

        field :contract_id, -> { String }, optional: true, nullable: false

        field :document_state, -> { Schematic::Types::InvoiceDocumentState }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
