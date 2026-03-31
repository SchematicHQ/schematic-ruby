# frozen_string_literal: true

module Schematic
  module Types
    class WebScheduledDowngradeWebhookOutput < Internal::Types::Model
      field :company, -> { Schematic::Types::CompanyResponseData }, optional: true, nullable: false
      field :execute_after, -> { String }, optional: false, nullable: false
      field :from_plan, -> { Schematic::Types::PlanSnapshotView }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :scheduled_interval, -> { String }, optional: true, nullable: false
      field :scheduled_price, -> { Integer }, optional: true, nullable: false
      field :to_plan, -> { Schematic::Types::PlanSnapshotView }, optional: true, nullable: false
    end
  end
end
