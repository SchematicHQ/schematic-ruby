# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class LookupCompanyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyDetailResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Companies::Types::LookupCompanyParams }, optional: false, nullable: false
      end
    end
  end
end
