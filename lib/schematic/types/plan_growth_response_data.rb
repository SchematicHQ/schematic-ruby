# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanGrowthResponseData < Internal::Types::Model
      field :points, -> { Internal::Types::Array[Schematic::Types::PlanGrowthPointResponseData] }, optional: false, nullable: false
    end
  end
end
