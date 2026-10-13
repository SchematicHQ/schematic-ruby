# frozen_string_literal: true

module Schematic
  module Types
    class CatalogConfigOrderedPlan < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::CatalogConfigPlanCredit] }, optional: true, nullable: false

      field :entitlements, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedEntitlement] }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
