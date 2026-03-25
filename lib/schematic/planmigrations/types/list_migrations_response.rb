# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class ListMigrationsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanVersionMigrationResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Planmigrations::Types::ListMigrationsParams }, optional: false, nullable: false
      end
    end
  end
end
