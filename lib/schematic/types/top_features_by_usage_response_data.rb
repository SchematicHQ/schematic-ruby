# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class TopFeaturesByUsageResponseData < Internal::Types::Model
      field :features, -> { Internal::Types::Array[Schematic::Types::TopFeatureByUsageResponseData] }, optional: false, nullable: false
    end
  end
end
