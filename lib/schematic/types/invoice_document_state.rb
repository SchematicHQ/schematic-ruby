# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module InvoiceDocumentState
      extend Schematic::Internal::Types::Enum

      CREDITED = "credited"
      DRAFT = "draft"
      FINALIZED = "finalized"
      VOID = "void"
    end
  end
end
