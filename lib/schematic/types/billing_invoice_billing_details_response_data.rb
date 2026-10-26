# frozen_string_literal: true

module Schematic
  module Types
    class BillingInvoiceBillingDetailsResponseData < Internal::Types::Model
      field :address, -> { Schematic::Types::BillingInvoiceAddressResponseData }, optional: true, nullable: false

      field :email, -> { String }, optional: true, nullable: false

      field :phone, -> { String }, optional: true, nullable: false

      field :tax_ids, -> { Internal::Types::Array[Schematic::Types::BillingInvoiceTaxIdResponseData] }, optional: false, nullable: false
    end
  end
end
