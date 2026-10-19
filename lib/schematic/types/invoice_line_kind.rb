# frozen_string_literal: true

module Schematic
  module Types
    module InvoiceLineKind
      extend Schematic::Internal::Types::Enum

      ADJUSTMENT = "adjustment"
      PURCHASE = "purchase"
      RECONCILIATION = "reconciliation"
      SUBSCRIPTION = "subscription"
      TRUE_UP = "true_up"
    end
  end
end
