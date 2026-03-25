# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class GetFeatureUsageTimeSeriesParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :end_time, -> { String }, optional: true, nullable: false
        field :feature_id, -> { String }, optional: true, nullable: false
        field :granularity, -> { Schematic::Types::TimeSeriesGranularity }, optional: true, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
