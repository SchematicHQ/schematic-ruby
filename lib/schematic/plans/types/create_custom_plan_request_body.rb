# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class CreateCustomPlanRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :copied_from_plan_id, -> { String }, optional: true, nullable: false
        field :description, -> { String }, optional: false, nullable: false
        field :icon, -> { Schematic::Types::PlanIcon }, optional: true, nullable: false
        field :name, -> { String }, optional: false, nullable: false
      end
    end
  end
end
