# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      # Input parameters
      class GetEnvironmentFeatureUsageTimeSeriesParams < Internal::Types::Model
        field :end_time, -> { String }, optional: true, nullable: false
        field :feature_id, -> { String }, optional: true, nullable: false
        field :granularity, -> { Schematic::Types::TimeSeriesGranularity }, optional: true, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
