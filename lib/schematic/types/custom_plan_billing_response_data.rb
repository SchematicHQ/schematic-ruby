# frozen_string_literal: true

module Schematic
  module Types
    class CustomPlanBillingResponseData < Internal::Types::Model
      field :activation_strategy, -> { Schematic::Types::CustomPlanActivationStrategy }, optional: false, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :days_until_due, -> { Integer }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :paid_at, -> { String }, optional: true, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :published_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::CustomPlanBillingStatus }, optional: false, nullable: false
      field :stripe_invoice_url, -> { String }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
