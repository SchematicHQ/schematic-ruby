# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogConfigOrderedPlanResponseData < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::CatalogConfigPlanCreditResponseData] }, optional: false, nullable: false

      field :entitlements, -> { Internal::Types::Array[Schematic::Types::CatalogConfigOrderedEntitlementResponseData] }, optional: false, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
