# frozen_string_literal: true

module Schematic
  module Types
    class CompanyUserUsageMetricsResponseData < Internal::Types::Model
      field :end_time, -> { String }, optional: false, nullable: false

      field :features, -> { Internal::Types::Array[Schematic::Types::FeatureResponseData] }, optional: false, nullable: false

      field :has_credits, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :start_time, -> { String }, optional: false, nullable: false
    end
  end
end
