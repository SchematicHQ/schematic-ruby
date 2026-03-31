# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      # Input parameters
      class ListPlanTraitsParams < Internal::Types::Model
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :trait_id, -> { String }, optional: true, nullable: false
        field :trait_ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
      end
    end
  end
end
