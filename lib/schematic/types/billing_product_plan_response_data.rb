# frozen_string_literal: true

module Schematic
  module Types
    class BillingProductPlanResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :billing_product_id, -> { String }, optional: false, nullable: false
      field :charge_type, -> { Schematic::Types::ChargeType }, optional: false, nullable: false
      field :controlled_by, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :is_trialable, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :monthly_price_id, -> { String }, optional: true, nullable: false
      field :one_time_price_id, -> { String }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :trial_days, -> { Integer }, optional: true, nullable: false
      field :yearly_price_id, -> { String }, optional: true, nullable: false
    end
  end
end
