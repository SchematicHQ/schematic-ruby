# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListFeatureCompaniesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FeatureCompanyResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Entitlements::Types::ListFeatureCompaniesParams }, optional: false, nullable: false
      end
    end
  end
end
