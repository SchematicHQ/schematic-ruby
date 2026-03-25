# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class CreatePlanTraitRequestBody < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false
        field :trait_id, -> { String }, optional: false, nullable: false
        field :trait_value, -> { String }, optional: false, nullable: false
      end
    end
  end
end
