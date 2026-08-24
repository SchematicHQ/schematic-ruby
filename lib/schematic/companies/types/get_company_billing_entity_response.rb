# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetCompanyBillingEntityResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyBillingEntityResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::GetCompanyBillingEntityParams }, optional: false, nullable: false
      end
    end
  end
end
