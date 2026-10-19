# frozen_string_literal: true

module Schematic
  module Types
    class BillingInvoiceTermsResponseData < Internal::Types::Model
      field :collection_method, -> { Schematic::Types::BillingCollectionMethod }, optional: false, nullable: false

      field :collector, -> { Schematic::Types::Collector }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: true, nullable: false

      field :days_until_due, -> { Integer }, optional: true, nullable: false

      field :payment_gating, -> { Schematic::Types::PaymentGating }, optional: false, nullable: false

      field :purchase_order, -> { String }, optional: true, nullable: false
    end
  end
end
