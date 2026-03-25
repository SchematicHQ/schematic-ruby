# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListCompaniesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::ListCompaniesParams }, optional: false, nullable: false
      end
    end
  end
end
