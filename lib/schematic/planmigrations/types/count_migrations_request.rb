# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class CountMigrationsRequest < Internal::Types::Model
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::PlanVersionMigrationStatus }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
