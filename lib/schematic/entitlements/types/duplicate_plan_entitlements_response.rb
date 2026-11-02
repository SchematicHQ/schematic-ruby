# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class DuplicatePlanEntitlementsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DuplicatePlanEntitlementsResponseResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
