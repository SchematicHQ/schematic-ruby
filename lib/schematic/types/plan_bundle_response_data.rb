# frozen_string_literal: true

module Schematic
  module Types
    class PlanBundleResponseData < Internal::Types::Model
      field :billing_product, -> { Schematic::Types::BillingProductPlanResponseData }, optional: true, nullable: false
      field :credit_grants, -> { Internal::Types::Array[Schematic::Types::BillingPlanCreditGrantResponseData] }, optional: true, nullable: false
      field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanEntitlementResponseData] }, optional: true, nullable: false
      field :plan, -> { Schematic::Types::PlanResponseData }, optional: true, nullable: false
      field :traits, -> { Internal::Types::Array[Schematic::Types::PlanTraitResponseData] }, optional: true, nullable: false
    end
  end
end
