# frozen_string_literal: true

module Schematic
  module Types
    class PlanVersionMigrationResponseData < Internal::Types::Model
      field :completed_at, -> { String }, optional: true, nullable: false
      field :completed_companies, -> { Integer }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :error, -> { String }, optional: true, nullable: false
      field :failed_companies, -> { Integer }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :plan_id, -> { String }, optional: false, nullable: false
      field :plan_version_id_from, -> { String }, optional: true, nullable: false
      field :plan_version_id_to, -> { String }, optional: false, nullable: false
      field :skipped_companies, -> { Integer }, optional: false, nullable: false
      field :started_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::PlanVersionMigrationStatus }, optional: false, nullable: false
      field :strategy, -> { Schematic::Types::PlanVersionMigrationStrategy }, optional: false, nullable: false
      field :total_companies, -> { Integer }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
