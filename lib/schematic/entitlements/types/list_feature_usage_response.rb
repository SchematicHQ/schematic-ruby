# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListFeatureUsageResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FeatureUsageResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::ListFeatureUsageParams }, optional: false, nullable: false
      end
    end
  end
end
