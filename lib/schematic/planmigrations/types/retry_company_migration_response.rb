# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class RetryCompanyMigrationResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanVersionCompanyMigrationResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
