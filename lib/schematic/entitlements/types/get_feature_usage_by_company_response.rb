# frozen_string_literal: true

require_relative "../../../schematic"

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
