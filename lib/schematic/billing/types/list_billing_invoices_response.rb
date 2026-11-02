# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ListBillingInvoicesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingInvoiceResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListBillingInvoicesParams }, optional: false, nullable: false
      end
    end
  end
end
