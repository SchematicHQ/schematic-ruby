# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class CreateMigrationInput < Internal::Types::Model
        field :company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :excluded_company_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :plan_id, -> { String }, optional: false, nullable: false

        field :plan_version_id_to, -> { String }, optional: false, nullable: false

        field :plan_version_ids_from, -> { Internal::Types::Array[String] }, optional: true, nullable: false

        field :proration_behavior, -> { Schematic::Types::MigrationProrationBehavior }, optional: true, nullable: false

        field :strategy, -> { Schematic::Types::PlanVersionMigrationStrategy }, optional: false, nullable: false

        field :target_plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
      end
    end
  end
end
