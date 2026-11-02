# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Planmigrations
    module Types
      class RetryMigrationResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PlanVersionMigrationResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
