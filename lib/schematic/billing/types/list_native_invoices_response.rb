# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class ListNativeInvoicesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::BillingInvoiceResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListNativeInvoicesParams }, optional: false, nullable: false
      end
    end
  end
end
