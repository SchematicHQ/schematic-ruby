# frozen_string_literal: true

module Schematic
  module Types
    class CreatePlanRequestBody < Internal::Types::Model
      field :description, -> { String }, optional: false, nullable: false
      field :icon, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :plan_type, -> { Schematic::Types::PlanType }, optional: false, nullable: false
    end
  end
end
