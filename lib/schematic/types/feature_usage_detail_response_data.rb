# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class FeatureUsageDetailResponseData < Internal::Types::Model
      field :features, -> { Internal::Types::Array[Schematic::Types::FeatureUsageResponseData] }, optional: false, nullable: false
    end
  end
end
