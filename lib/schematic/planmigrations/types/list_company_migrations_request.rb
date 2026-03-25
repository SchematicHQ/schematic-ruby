# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class ListCompanyMigrationsRequest < Internal::Types::Model
        field :migration_id, -> { String }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::PlanVersionCompanyMigrationStatus }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
