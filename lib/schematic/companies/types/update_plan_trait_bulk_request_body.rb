# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class UpdatePlanTraitBulkRequestBody < Internal::Types::Model
        field :apply_to_existing_companies, -> { Internal::Types::Boolean }, optional: false, nullable: false
        field :plan_id, -> { String }, optional: false, nullable: false
        field :traits, -> { Internal::Types::Array[Schematic::Types::UpdatePlanTraitTraitRequestBody] }, optional: false, nullable: false
      end
    end
  end
end
