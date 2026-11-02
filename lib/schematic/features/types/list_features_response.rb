# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Features
    module Types
      class ListFeaturesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::FeatureDetailResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Features::Types::ListFeaturesParams }, optional: false, nullable: false
      end
    end
  end
end
