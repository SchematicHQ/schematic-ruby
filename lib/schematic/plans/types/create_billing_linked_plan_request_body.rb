# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class CreateBillingLinkedPlanRequestBody < Internal::Types::Model
        field :billing_provider, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
        field :description, -> { String }, optional: false, nullable: false
        field :external_resource_id, -> { String }, optional: false, nullable: false
        field :icon, -> { Schematic::Types::PlanIcon }, optional: true, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
      end
    end
  end
end
