# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingUpcomingInvoicesResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :invoices, -> { Internal::Types::Array[Schematic::Types::BillingUpcomingInvoiceResponseData] }, optional: false, nullable: false
    end
  end
end
