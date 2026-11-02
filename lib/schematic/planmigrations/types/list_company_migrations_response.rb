# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Planmigrations
    module Types
      class ListCompanyMigrationsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanVersionCompanyMigrationResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Planmigrations::Types::ListCompanyMigrationsParams }, optional: false, nullable: false
      end
    end
  end
end
