# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetFeatureUsageByCompanyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::FeatureUsageDetailResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::GetFeatureUsageByCompanyParams }, optional: false, nullable: false
      end
    end
  end
end
