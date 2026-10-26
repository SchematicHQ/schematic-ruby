# frozen_string_literal: true

module Schematic
  module Types
    class BillingInvoiceLineResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :charge_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :description, -> { String }, optional: true, nullable: false

      field :external_id, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: true, nullable: false

      field :kind, -> { Schematic::Types::InvoiceLineKind }, optional: false, nullable: false

      field :period_end, -> { String }, optional: true, nullable: false

      field :period_start, -> { String }, optional: true, nullable: false

      field :quantity, -> { Integer }, optional: true, nullable: false

      field :subscription_line_id, -> { String }, optional: true, nullable: false

      field :taxable, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :unit_amount, -> { Integer }, optional: true, nullable: false
    end
  end
end
