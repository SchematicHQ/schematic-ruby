# frozen_string_literal: true

module Schematic
  module Types
    class DuplicatePlanEntitlementsResponseResponseData < Internal::Types::Model
      field :data, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementResponseData] }, optional: false, nullable: false
      field :skipped, -> { Internal::Types::Array[Schematic::Types::SkippedEntitlementResponseData] }, optional: false, nullable: false
    end
  end
end
