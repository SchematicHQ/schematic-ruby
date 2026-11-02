# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module InvoiceCollectionState
      extend Schematic::Internal::Types::Enum

      EXPORTED = "exported"
      PAID = "paid"
      PARTIALLY_PAID = "partially_paid"
      PAST_DUE = "past_due"
      PAYMENT_FAILED = "payment_failed"
      QUEUED = "queued"
      SENT = "sent"
    end
  end
end
