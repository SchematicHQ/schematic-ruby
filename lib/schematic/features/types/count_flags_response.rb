# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Features
    module Types
      class CountFlagsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false

        field :params, -> { Schematic::Features::Types::CountFlagsParams }, optional: false, nullable: false
      end
    end
  end
end
