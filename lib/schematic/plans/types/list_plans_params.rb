# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      # Input parameters
      class ListPlansParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :for_fallback_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :for_initial_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :for_trial_expiry_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :has_product_id, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :include_draft_versions, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_type, -> { Schematic::Types::PlanType }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :without_entitlement_for, -> { String }, optional: true, nullable: false
        field :without_paid_product_id, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
