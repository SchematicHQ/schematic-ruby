# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionPriceChangeResponseData < Internal::Types::Model
      field :cadence, -> { Schematic::Types::PlanVersionDiffPriceCadence }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :new, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false

      field :old, -> { Schematic::Types::BillingPriceResponseData }, optional: true, nullable: false
    end
  end
end
