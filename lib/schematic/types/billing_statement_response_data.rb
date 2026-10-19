# frozen_string_literal: true

module Schematic
  module Types
    class BillingStatementResponseData < Internal::Types::Model
      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::BillingStatementLineResponseData] }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :subtotal, -> { Integer }, optional: false, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false
    end
  end
end
