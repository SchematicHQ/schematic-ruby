# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListFeatureUsageHistoryRequest < Internal::Types::Model
        field :company_ids, -> { String }, optional: true, nullable: false

        field :end_time, -> { String }, optional: false, nullable: false

        field :feature_ids, -> { String }, optional: true, nullable: false

        field :granularity, -> { Schematic::Types::TimeSeriesGranularity }, optional: true, nullable: false

        field :start_time, -> { String }, optional: false, nullable: false

        field :limit, -> { Integer }, optional: true, nullable: false

        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
