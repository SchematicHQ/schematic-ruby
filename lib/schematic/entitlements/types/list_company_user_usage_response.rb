# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class ListCompanyUserUsageResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyUserUsageResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::ListCompanyUserUsageParams }, optional: false, nullable: false
      end
    end
  end
end
