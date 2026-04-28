# frozen_string_literal: true

module Schematic
  module Types
    class PlanGrowthResponseData < Internal::Types::Model
      field :points, -> { Internal::Types::Array[Schematic::Types::PlanGrowthPointResponseData] }, optional: false, nullable: false
    end
  end
end
