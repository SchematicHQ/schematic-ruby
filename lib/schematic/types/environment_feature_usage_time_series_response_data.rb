# frozen_string_literal: true

module Schematic
  module Types
    class EnvironmentFeatureUsageTimeSeriesResponseData < Internal::Types::Model
      field :event_subtype, -> { String }, optional: false, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :points, -> { Internal::Types::Array[Schematic::Types::EnvironmentUsagePointResponseData] }, optional: false, nullable: false
    end
  end
end
