# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class CountComponentsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Components::Types::CountComponentsParams }, optional: false, nullable: false
      end
    end
  end
end
