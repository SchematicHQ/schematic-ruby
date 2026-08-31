# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class CompleteMigrationNowRequestBody < Internal::Types::Model
        field :plan_version_migration_id, -> { String }, optional: false, nullable: false

        field :proration_behavior, -> { Schematic::Types::MigrationProrationBehavior }, optional: true, nullable: false
      end
    end
  end
end
