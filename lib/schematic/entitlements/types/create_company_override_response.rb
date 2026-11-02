# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class CreateCompanyOverrideResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyOverrideResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
