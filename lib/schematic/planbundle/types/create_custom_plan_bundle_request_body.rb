# frozen_string_literal: true

module Schematic
  module Planbundle
    module Types
      class CreateCustomPlanBundleRequestBody < Internal::Types::Model
        field :billing_product, -> { Schematic::Types::UpsertBillingProductRequestBody }, optional: false, nullable: false

        field :credit_grants, -> { Internal::Types::Array[Schematic::Types::PlanBundleCreditGrantRequestBody] }, optional: true, nullable: false

        field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanBundleEntitlementRequestBody] }, optional: false, nullable: false

        field :plan, -> { Schematic::Types::CreateCustomPlanBundlePlanRequestBody }, optional: false, nullable: false
      end
    end
  end
end
