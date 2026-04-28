# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      class GetEnvironmentFeatureUsageTimeSeriesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::EnvironmentFeatureUsageTimeSeriesResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Insights::Types::GetEnvironmentFeatureUsageTimeSeriesParams }, optional: false, nullable: false
      end
    end
  end
end
