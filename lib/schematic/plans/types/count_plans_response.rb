# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Plans
    module Types
      class CountPlansResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Plans::Types::CountPlansParams }, optional: false, nullable: false
      end
    end
  end
end
