# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class UpdatePlanTraitsBulkResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanTraitResponseData] }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
