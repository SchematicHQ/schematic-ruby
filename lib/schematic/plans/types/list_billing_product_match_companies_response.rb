# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class ListBillingProductMatchCompaniesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Plans::Types::ListBillingProductMatchCompaniesParams }, optional: false, nullable: false
      end
    end
  end
end
