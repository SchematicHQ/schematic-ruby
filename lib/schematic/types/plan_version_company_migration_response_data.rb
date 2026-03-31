# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionCompanyMigrationResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false
      field :company_name, -> { String }, optional: false, nullable: false
      field :completed_at, -> { String }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :error, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :migration_id, -> { String }, optional: false, nullable: false
      field :plan_version_id_from, -> { String }, optional: true, nullable: false
      field :started_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::PlanVersionCompanyMigrationStatus }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
