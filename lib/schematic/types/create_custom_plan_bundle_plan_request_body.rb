# frozen_string_literal: true

module Schematic
  module Types
    class CreateCustomPlanBundlePlanRequestBody < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :description, -> { String }, optional: true, nullable: false

      field :icon, -> { Schematic::Types::PlanIcon }, optional: true, nullable: false

      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
