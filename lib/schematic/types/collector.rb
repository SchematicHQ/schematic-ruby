# frozen_string_literal: true

module Schematic
  module Types
    module Collector
      extend Schematic::Internal::Types::Enum

      EXTERNAL = "external"
      STRIPE_INVOICE = "stripe_invoice"
      STRIPE_PAYMENTS = "stripe_payments"
    end
  end
end
