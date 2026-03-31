# frozen_string_literal: true

module Schematic
  module Planbundle
    module Types
      class CreatePlanBundleRequestBody < Internal::Types::Model
        field :billing_product, -> { Schematic::Types::UpsertBillingProductRequestBody }, optional: true, nullable: false
        field :credit_grants, -> { Internal::Types::Array[Schematic::Types::PlanBundleCreditGrantRequestBody] }, optional: true, nullable: false
        field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanBundleEntitlementRequestBody] }, optional: false, nullable: false
        field :plan, -> { Schematic::Types::CreatePlanRequestBody }, optional: true, nullable: false
        field :traits, -> { Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody] }, optional: true, nullable: false
      end
    end
  end
end
