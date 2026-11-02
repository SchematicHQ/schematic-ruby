# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EnvironmentTraitUsageTimeSeriesResponseData < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false

      field :points, -> { Internal::Types::Array[Schematic::Types::EnvironmentUsagePointResponseData] }, optional: false, nullable: false

      field :trait_definition_id, -> { String }, optional: false, nullable: false
    end
  end
end
