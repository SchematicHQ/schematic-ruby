# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Insights
    module Types
      class GetTopFeaturesByUsageResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::TopFeaturesByUsageResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Insights::Types::GetTopFeaturesByUsageParams }, optional: false, nullable: false
      end
    end
  end
end
