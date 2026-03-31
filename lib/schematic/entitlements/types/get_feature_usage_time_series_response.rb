# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetFeatureUsageTimeSeriesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::FeatureUsageTimeSeriesResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::GetFeatureUsageTimeSeriesParams }, optional: false, nullable: false
      end
    end
  end
end
