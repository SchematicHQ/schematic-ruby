# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class CountFeatureUsageResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::CountFeatureUsageParams }, optional: false, nullable: false
      end
    end
  end
end
