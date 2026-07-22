# frozen_string_literal: true

module Schematic
  module Types
    class CatalogConfigOrderedEntitlementResponseData < Internal::Types::Model
      field :plan_entitlement_id, -> { String }, optional: false, nullable: false
      field :visible, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
