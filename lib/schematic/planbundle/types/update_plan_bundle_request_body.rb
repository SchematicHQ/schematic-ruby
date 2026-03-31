# frozen_string_literal: true

module Schematic
  module Planbundle
    module Types
      class UpdatePlanBundleRequestBody < Internal::Types::Model
        field :plan_bundle_id, -> { String }, optional: false, nullable: false
        field :billing_product, -> { Schematic::Types::UpsertBillingProductRequestBody }, optional: true, nullable: false
        field :credit_grants, -> { Internal::Types::Array[Schematic::Types::PlanBundleCreditGrantRequestBody] }, optional: true, nullable: false
        field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanBundleEntitlementRequestBody] }, optional: false, nullable: false
        field :plan, -> { Schematic::Types::UpdatePlanRequestBody }, optional: true, nullable: false
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :traits, -> { Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody] }, optional: true, nullable: false
      end
    end
  end
end
