# frozen_string_literal: true

module Schematic
  module Types
    class FeatureUsageTimeSeriesResponseData < Internal::Types::Model
      field :feature_id, -> { String }, optional: false, nullable: false
      field :feature_type, -> { Schematic::Types::FeatureType }, optional: false, nullable: false
      field :limits, -> { Internal::Types::Array[Schematic::Types::LimitTimeSeriesPointResponseData] }, optional: false, nullable: false
      field :period_type, -> { String }, optional: true, nullable: false
      field :usage_points, -> { Internal::Types::Array[Schematic::Types::UsageTimeSeriesPointResponseData] }, optional: false, nullable: false
    end
  end
end
