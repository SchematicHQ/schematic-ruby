# frozen_string_literal: true

module Schematic
  module Types
    class PendingMigrationResponseData < Internal::Types::Model
      field :effective_at, -> { String }, optional: true, nullable: false

      field :migration_id, -> { String }, optional: false, nullable: false

      field :proration_behavior, -> { Schematic::Types::MigrationProrationBehavior }, optional: true, nullable: false

      field :scheduled_for, -> { String }, optional: true, nullable: false

      field :strategy, -> { Schematic::Types::PlanVersionMigrationStrategy }, optional: false, nullable: false

      field :to_plan_id, -> { String }, optional: false, nullable: false

      field :to_plan_name, -> { String }, optional: false, nullable: false

      field :to_plan_version_id, -> { String }, optional: false, nullable: false

      field :to_plan_version_number, -> { Integer }, optional: true, nullable: false
    end
  end
end
