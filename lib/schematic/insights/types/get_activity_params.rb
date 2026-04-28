# frozen_string_literal: true

module Schematic
  module Insights
    module Types
      # Input parameters
      class GetActivityParams < Internal::Types::Model
        field :limit, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
