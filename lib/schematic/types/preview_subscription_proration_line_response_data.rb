# frozen_string_literal: true

module Schematic
  module Types
    class PreviewSubscriptionProrationLineResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :kind, -> { Schematic::Types::ProrationLineKind }, optional: false, nullable: false

      field :period_end, -> { String }, optional: true, nullable: false

      field :period_start, -> { String }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :price_id, -> { String }, optional: true, nullable: false

      field :quantity, -> { Integer }, optional: true, nullable: false
    end
  end
end
