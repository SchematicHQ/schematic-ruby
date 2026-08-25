# frozen_string_literal: true

module Schematic
  module Licenses
    module Types
      class GetSingleLicenseResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::LicenseResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
