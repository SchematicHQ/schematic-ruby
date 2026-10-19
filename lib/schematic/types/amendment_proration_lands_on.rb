# frozen_string_literal: true

module Schematic
  module Types
    module AmendmentProrationLandsOn
      extend Schematic::Internal::Types::Enum

      IMMEDIATE_INVOICE = "immediate_invoice"
      NEXT_INVOICE = "next_invoice"
      NONE = "none"
    end
  end
end
