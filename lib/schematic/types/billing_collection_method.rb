# frozen_string_literal: true

module Schematic
  module Types
    module BillingCollectionMethod
      extend Schematic::Internal::Types::Enum

      CHARGE_AUTOMATICALLY = "charge_automatically"
      SEND_INVOICE = "send_invoice"
    end
  end
end
