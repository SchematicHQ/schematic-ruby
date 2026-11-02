# frozen_string_literal: true

require_relative "../../../schematic"

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
