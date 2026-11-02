# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class DeletePlanVersionResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::DeletePlanVersionParams }, optional: false, nullable: false
      end
    end
  end
end
