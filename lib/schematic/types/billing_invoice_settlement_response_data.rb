# frozen_string_literal: true

module Schematic
  module Types
    class BillingInvoiceSettlementResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :collector, -> { Schematic::Types::Collector }, optional: false, nullable: false

      field :id, -> { String }, optional: true, nullable: false

      field :reference, -> { String }, optional: true, nullable: false

      field :settled_at, -> { String }, optional: false, nullable: false
    end
  end
end
