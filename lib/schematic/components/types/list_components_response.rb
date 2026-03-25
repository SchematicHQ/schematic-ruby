# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class ListComponentsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::ComponentResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Components::Types::ListComponentsParams }, optional: false, nullable: false
      end
    end
  end
end
