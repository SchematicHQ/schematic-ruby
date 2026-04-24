# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      # Input parameters
      class ListCustomPlanBillingsParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::CustomPlanBillingStatus }, optional: true, nullable: false
        field :statuses, -> { Internal::Types::Array[Schematic::Types::CustomPlanBillingStatus] }, optional: true, nullable: false
      end
    end
  end
end
