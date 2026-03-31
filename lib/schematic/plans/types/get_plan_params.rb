# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      # Input parameters
      class GetPlanParams < Internal::Types::Model
        field :plan_version_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
