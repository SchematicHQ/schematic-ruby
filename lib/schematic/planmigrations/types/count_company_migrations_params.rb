# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      # Input parameters
      class CountCompanyMigrationsParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false
        field :migration_id, -> { String }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::PlanVersionCompanyMigrationStatus }, optional: true, nullable: false
      end
    end
  end
end
