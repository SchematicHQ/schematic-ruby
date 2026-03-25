# frozen_string_literal: true

module Schematic
  module Types
    class SkippedEntitlementResponseData < Internal::Types::Model
      field :entitlement_id, -> { String }, optional: false, nullable: false
      field :errors, -> { Internal::Types::Array[Schematic::Types::SkippedEntitlementErrorResponseData] }, optional: false, nullable: false
      field :feature_id, -> { String }, optional: false, nullable: false
      field :feature_name, -> { String }, optional: false, nullable: false
    end
  end
end
