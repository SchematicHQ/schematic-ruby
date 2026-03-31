# frozen_string_literal: true

module Schematic
  module Types
    class PlanGroupPlanEntitlementsOrder < Internal::Types::Model
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementsOrder] }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
