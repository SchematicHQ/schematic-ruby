# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class ListFeatureUsageHistoryParams < Internal::Types::Model
        field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :end_time, -> { String }, optional: true, nullable: false

        field :feature_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :granularity, -> { Schematic::Types::TimeSeriesGranularity }, optional: true, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false

        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
