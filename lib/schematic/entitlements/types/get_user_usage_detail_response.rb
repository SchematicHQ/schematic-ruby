# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetUserUsageDetailResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::UserUsageDetailResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::GetUserUsageDetailParams }, optional: false, nullable: false
      end
    end
  end
end
