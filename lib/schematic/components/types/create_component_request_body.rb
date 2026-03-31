# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class CreateComponentRequestBody < Internal::Types::Model
        field :ast, -> { Internal::Types::Hash[String, Integer] }, optional: true, nullable: false
        field :entity_type, -> { Schematic::Types::ComponentEntityType }, optional: false, nullable: false
        field :name, -> { String }, optional: false, nullable: false
      end
    end
  end
end
