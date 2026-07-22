# frozen_string_literal: true

module Schematic
  module Types
    class CatalogConfigOrderedPlanResponseData < Internal::Types::Model
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedEntitlementResponseData] }, optional: false, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
