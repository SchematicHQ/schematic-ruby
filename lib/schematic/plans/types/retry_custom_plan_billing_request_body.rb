# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class RetryCustomPlanBillingRequestBody < Internal::Types::Model
        field :custom_plan_billing_id, -> { String }, optional: false, nullable: false
        field :activation_strategy, -> { Schematic::Types::CustomPlanActivationStrategy }, optional: true, nullable: false
        field :customer_email, -> { String }, optional: false, nullable: false
        field :days_until_due, -> { Integer }, optional: true, nullable: false
        field :pay_in_advance, -> { Internal::Types::Array[Schematic::Types::UpdatePayInAdvanceRequestBody] }, optional: false, nullable: false
      end
    end
  end
end
