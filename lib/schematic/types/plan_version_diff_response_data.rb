# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionDiffResponseData < Internal::Types::Model
      field :billing_product, -> { Schematic::Types::PlanVersionBillingProductChangeResponseData }, optional: true, nullable: false

      field :credit_grants, -> { Internal::Types::Array[Schematic::Types::PlanVersionCreditGrantChangeResponseData] }, optional: false, nullable: false

      field :entitlements, -> { Internal::Types::Array[Schematic::Types::PlanVersionEntitlementChangeResponseData] }, optional: false, nullable: false

      field :from, -> { Schematic::Types::PlanVersionResponseData }, optional: true, nullable: false

      field :has_billing_changes, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :plan_fields, -> { Internal::Types::Array[Schematic::Types::PlanVersionFieldChangeResponseData] }, optional: false, nullable: false

      field :prices, -> { Internal::Types::Array[Schematic::Types::PlanVersionPriceChangeResponseData] }, optional: false, nullable: false

      field :to, -> { Schematic::Types::PlanVersionResponseData }, optional: true, nullable: false
    end
  end
end
