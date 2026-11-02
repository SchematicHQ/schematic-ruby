# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Entitlements
    module Types
      class ListPlanEntitlementsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::ListPlanEntitlementsParams }, optional: false, nullable: false
      end
    end
  end
end
