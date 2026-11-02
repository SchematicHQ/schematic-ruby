# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Licenses
    module Types
      class ListLicensesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::LicenseResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Licenses::Types::ListLicensesParams }, optional: false, nullable: false
      end
    end
  end
end
