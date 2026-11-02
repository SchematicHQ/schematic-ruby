# frozen_string_literal: true

require_relative "../../../schematic"

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
