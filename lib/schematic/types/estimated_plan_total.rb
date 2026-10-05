# frozen_string_literal: true

module Schematic
  module Types
    class EstimatedPlanTotal < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :currency, -> { String }, optional: false, nullable: false

      field :period, -> { Schematic::Types::PlanPriceCadence }, optional: false, nullable: false
    end
  end
end
