# frozen_string_literal: true

module Schematic
  module Types
    class PlanEntitlementsOrder < Internal::Types::Model
      field :plan_entitlement_id, -> { String }, optional: false, nullable: false
      field :visible, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
