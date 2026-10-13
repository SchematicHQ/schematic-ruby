# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionEntitlementChangeResponseData < Internal::Types::Model
      field :change_type, -> { Schematic::Types::PlanVersionDiffChangeType }, optional: false, nullable: false

      field :changed_fields, -> { Internal::Types::Array[String] }, optional: false, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false

      field :new, -> { Schematic::Types::PlanEntitlementResponseData }, optional: true, nullable: false

      field :old, -> { Schematic::Types::PlanEntitlementResponseData }, optional: true, nullable: false
    end
  end
end
