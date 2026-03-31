# frozen_string_literal: true

module Schematic
  module Types
    class EntitlementsInPlan < Internal::Types::Model
      field :entitlement_id, -> { String }, optional: false, nullable: false
      field :visible, -> { Internal::Types::Boolean }, optional: true, nullable: false
    end
  end
end
