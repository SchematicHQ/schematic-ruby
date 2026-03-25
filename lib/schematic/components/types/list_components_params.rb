# frozen_string_literal: true

module Schematic
  module Components
    module Types
      # Input parameters
      class ListComponentsParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
