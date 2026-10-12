# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      # Input parameters
      class GetPlanVersionDiffParams < Internal::Types::Model
        field :against, -> { String }, optional: true, nullable: false
      end
    end
  end
end
