# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class ListPlanChangesRequest < Internal::Types::Model
        field :action, -> { Schematic::Types::PlanChangeAction }, optional: true, nullable: false
        field :base_plan_action, -> { Schematic::Types::PlanChangeBasePlanAction }, optional: true, nullable: false
        field :company_id, -> { String }, optional: true, nullable: false
        field :company_ids, -> { String }, optional: true, nullable: false
        field :plan_ids, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
