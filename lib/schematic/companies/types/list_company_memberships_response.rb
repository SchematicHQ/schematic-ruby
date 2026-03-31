# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListCompanyMembershipsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyMembershipDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListCompanyMembershipsParams }, optional: false, nullable: false
      end
    end
  end
end
