# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class ListFeatureUsersResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FeatureCompanyUserResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::ListFeatureUsersParams }, optional: false, nullable: false
      end
    end
  end
end
