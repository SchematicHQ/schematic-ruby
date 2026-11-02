# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class DuplicatePlanEntitlementsResponseResponseData < Internal::Types::Model
      field :data, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementResponseData] }, optional: false, nullable: false

      field :issues, -> { Internal::Types::Array[Schematic::Types::PlanIssueResponseData] }, optional: false, nullable: false

      field :skipped, -> { Internal::Types::Array[Schematic::Types::SkippedEntitlementResponseData] }, optional: false, nullable: false
    end
  end
end
