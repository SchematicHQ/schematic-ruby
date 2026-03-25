# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class ListPlansResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::PlanDetailResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Plans::Types::ListPlansParams }, optional: false, nullable: false
      end
    end
  end
end
