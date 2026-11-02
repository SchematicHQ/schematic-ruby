# frozen_string_literal: true

require_relative "../../../schematic"

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
