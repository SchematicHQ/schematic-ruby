# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListFeatureUsageHistoryResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FeatureUsageHistoryResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::ListFeatureUsageHistoryParams }, optional: false, nullable: false
      end
    end
  end
end
