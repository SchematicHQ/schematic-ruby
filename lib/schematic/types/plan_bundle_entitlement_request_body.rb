# frozen_string_literal: true

module Schematic
  module Types
    class PlanBundleEntitlementRequestBody < Internal::Types::Model
      field :action, -> { Schematic::Types::PlanBundleAction }, optional: false, nullable: false
      field :entitlement_id, -> { String }, optional: true, nullable: false
      field :req, -> { Schematic::Types::CreateEntitlementInBundleRequestBody }, optional: true, nullable: false
    end
  end
end
