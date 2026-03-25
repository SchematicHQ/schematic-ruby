# frozen_string_literal: true

module Schematic
  module Types
    class ScheduledCheckoutResponseData < Internal::Types::Model
      field :actor_type, -> { String }, optional: false, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :completed_at, -> { String }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :error_message, -> { String }, optional: true, nullable: false
      field :execute_after, -> { String }, optional: false, nullable: false
      field :from_plan_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :scheduled_interval, -> { String }, optional: true, nullable: false
      field :scheduled_price, -> { Integer }, optional: true, nullable: false
      field :started_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::ScheduledCheckoutStatus }, optional: false, nullable: false
      field :to_plan_id, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
