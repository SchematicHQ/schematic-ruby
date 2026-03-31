# frozen_string_literal: true

module Schematic
  module Types
    class ScheduledDowngradeResponseData < Internal::Types::Model
      field :currency, -> { String }, optional: false, nullable: false
      field :effective_after, -> { String }, optional: false, nullable: false
      field :from_plan_id, -> { String }, optional: false, nullable: false
      field :from_plan_name, -> { String }, optional: false, nullable: false
      field :from_subscription_price, -> { Integer }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :interval, -> { String }, optional: false, nullable: false
      field :scheduled_interval, -> { String }, optional: true, nullable: false
      field :scheduled_price, -> { Integer }, optional: true, nullable: false
      field :to_plan_id, -> { String }, optional: false, nullable: false
      field :to_plan_name, -> { String }, optional: false, nullable: false
    end
  end
end
