# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class MarkInvoicePaidRequestBody < Internal::Types::Model
        field :invoice_id, -> { String }, optional: false, nullable: false

        field :amount, -> { Integer }, optional: true, nullable: false

        field :idempotency_key, -> { String }, optional: false, nullable: false

        field :reference, -> { String }, optional: true, nullable: false

        field :settled_at, -> { String }, optional: true, nullable: false
      end
    end
  end
end
