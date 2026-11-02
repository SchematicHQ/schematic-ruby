# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class BillingStatementLineResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :description, -> { String }, optional: true, nullable: false

      field :kind, -> { Schematic::Types::InvoiceLineKind }, optional: false, nullable: false

      field :period_end, -> { String }, optional: true, nullable: false

      field :period_start, -> { String }, optional: true, nullable: false

      field :proration_fraction, -> { String }, optional: true, nullable: false

      field :quantity, -> { Integer }, optional: true, nullable: false

      field :subscription_line_id, -> { String }, optional: true, nullable: false

      field :unit_amount, -> { Integer }, optional: true, nullable: false
    end
  end
end
