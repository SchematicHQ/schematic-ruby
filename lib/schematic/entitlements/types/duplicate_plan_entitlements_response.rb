# frozen_string_literal: true

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
