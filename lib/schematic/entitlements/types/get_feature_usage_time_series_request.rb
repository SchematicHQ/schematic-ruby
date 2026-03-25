# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetFeatureUsageTimeSeriesRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :end_time, -> { String }, optional: false, nullable: false
        field :feature_id, -> { String }, optional: false, nullable: false
        field :granularity, -> { Schematic::Types::TimeSeriesGranularity }, optional: true, nullable: false
        field :start_time, -> { String }, optional: false, nullable: false
      end
    end
  end
end
