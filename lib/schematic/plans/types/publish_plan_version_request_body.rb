# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class PublishPlanVersionRequestBody < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false
        field :excluded_company_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
        field :migration_strategy, -> { Schematic::Types::PlanVersionMigrationStrategy }, optional: false, nullable: false
      end
    end
  end
end
