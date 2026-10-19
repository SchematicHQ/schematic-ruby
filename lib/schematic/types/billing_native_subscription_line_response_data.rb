# frozen_string_literal: true

module Schematic
  module Types
    class BillingNativeSubscriptionLineResponseData < Internal::Types::Model
      field :anchor, -> { String }, optional: false, nullable: false

      field :anchor_day, -> { Integer }, optional: false, nullable: false

      field :base, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :cadence_count, -> { Integer }, optional: false, nullable: false

      field :cadence_unit, -> { Schematic::Types::BillingProductPriceInterval }, optional: false, nullable: false

      field :currency, -> { Schematic::Types::Currency }, optional: false, nullable: false

      field :current_period_end, -> { String }, optional: true, nullable: false

      field :current_period_start, -> { String }, optional: true, nullable: false

      field :effective_from, -> { String }, optional: false, nullable: false

      field :effective_to, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :kind, -> { Schematic::Types::LineKind }, optional: false, nullable: false

      field :quantity, -> { Integer }, optional: false, nullable: false

      field :source_id, -> { String }, optional: false, nullable: false

      field :source_name, -> { String }, optional: true, nullable: false

      field :source_plan_type, -> { Schematic::Types::PlanType }, optional: true, nullable: false

      field :taxable, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :tiers_mode, -> { Schematic::Types::BillingTiersMode }, optional: true, nullable: false

      field :timing, -> { Schematic::Types::ChargeTiming }, optional: false, nullable: false

      field :unit_amount, -> { Integer }, optional: true, nullable: false
    end
  end
end
