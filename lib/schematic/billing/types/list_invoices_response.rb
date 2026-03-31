# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListInvoicesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::InvoiceResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Billing::Types::ListInvoicesParams }, optional: false, nullable: false
      end
    end
  end
end
