# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class UpdateComponentRequestBody < Internal::Types::Model
        field :component_id, -> { String }, optional: false, nullable: false
        field :ast, -> { Internal::Types::Hash[String, Integer] }, optional: true, nullable: false
        field :entity_type, -> { Schematic::Types::ComponentEntityType }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
        field :state, -> { Schematic::Types::ComponentState }, optional: true, nullable: false
      end
    end
  end
end
