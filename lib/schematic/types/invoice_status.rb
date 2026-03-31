# frozen_string_literal: true

module Schematic
  module Types
    module InvoiceStatus
      extend Schematic::Internal::Types::Enum

      DRAFT = "draft"
      OPEN = "open"
      PAID = "paid"
      UNCOLLECTIBLE = "uncollectible"
      VOID = "void"
    end
  end
end
