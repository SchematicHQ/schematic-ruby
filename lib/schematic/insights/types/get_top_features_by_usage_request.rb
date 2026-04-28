# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      class GetTopFeaturesByUsageRequest < Internal::Types::Model
        field :end_time, -> { String }, optional: false, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :start_time, -> { String }, optional: false, nullable: false
      end
    end
  end
end
