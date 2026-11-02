# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Insights
    module Types
      class GetEnvironmentTraitUsageTimeSeriesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::EnvironmentTraitUsageTimeSeriesResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Insights::Types::GetEnvironmentTraitUsageTimeSeriesParams }, optional: false, nullable: false
      end
    end
  end
end
