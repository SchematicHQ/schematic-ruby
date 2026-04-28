# frozen_string_literal: true

module Schematic
  module Types
    class EnvironmentTraitUsageTimeSeriesResponseData < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false
      field :points, -> { Internal::Types::Array[Schematic::Types::EnvironmentUsagePointResponseData] }, optional: false, nullable: false
      field :trait_definition_id, -> { String }, optional: false, nullable: false
    end
  end
end
