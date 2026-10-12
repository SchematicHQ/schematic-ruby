# frozen_string_literal: true

module Schematic
  module Types
    class OrderedPlansInGroup < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::CreditsInPlan] }, optional: true, nullable: false

      field :entitlements, -> { Internal::Types::Array[Schematic::Types::EntitlementsInPlan] }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: false, nullable: false
    end
  end
end
