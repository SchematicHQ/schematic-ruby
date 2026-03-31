# frozen_string_literal: true

module Schematic
  module Features
    module Types
      class CountFeaturesResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CountResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Features::Types::CountFeaturesParams }, optional: false, nullable: false
      end
    end
  end
end
