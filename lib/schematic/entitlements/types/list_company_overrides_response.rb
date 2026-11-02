# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class ListCompanyOverridesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyOverrideResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::ListCompanyOverridesParams }, optional: false, nullable: false
      end
    end
  end
end
