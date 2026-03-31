# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class DeletePlanTraitResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
