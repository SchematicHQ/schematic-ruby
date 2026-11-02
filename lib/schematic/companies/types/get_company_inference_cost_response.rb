# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class GetCompanyInferenceCostResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyInferenceCostResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::GetCompanyInferenceCostParams }, optional: false, nullable: false
      end
    end
  end
end
