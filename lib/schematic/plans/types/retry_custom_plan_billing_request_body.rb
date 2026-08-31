# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class RetryCustomPlanBillingRequestBody < Internal::Types::Model
        field :custom_plan_billing_id, -> { String }, optional: false, nullable: false

        field :activation_strategy, -> { Schematic::Types::CustomPlanActivationStrategy }, optional: true, nullable: false

        field :billing_cycle_anchor, -> { String }, optional: true, nullable: false

        field :customer_email, -> { String }, optional: false, nullable: false

        field :days_until_due, -> { Integer }, optional: true, nullable: false

        field :prorate_first_period, -> { Internal::Types::Boolean }, optional: true, nullable: false

        field :send_invoice, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
