# frozen_string_literal: true

module Schematic
  module Types
    class PreviewSubscriptionProrationResponseData < Internal::Types::Model
      field :billed_at, -> { String }, optional: true, nullable: false

      field :charge, -> { Integer }, optional: false, nullable: false

      field :credit, -> { Integer }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :lines, -> { Internal::Types::Array[Schematic::Types::PreviewSubscriptionProrationLineResponseData] }, optional: false, nullable: false

      field :timing, -> { Schematic::Types::CheckoutChargeTiming }, optional: false, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false
    end
  end
end
