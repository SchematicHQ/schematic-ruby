# frozen_string_literal: true

module Schematic
  module Planmigrations
    module Types
      class RetryMigrationRequestBody < Internal::Types::Model
        field :plan_version_migration_id, -> { String }, optional: false, nullable: false
        field :error_codes, -> { Internal::Types::Array[Schematic::Types::MigrationErrorCode] }, optional: false, nullable: false
      end
    end
  end
end
