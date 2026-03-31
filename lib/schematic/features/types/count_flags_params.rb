# frozen_string_literal: true

module Schematic
  module Features
    module Types
      # Input parameters
      class CountFlagsParams < Internal::Types::Model
        field :feature_id, -> { String }, optional: true, nullable: false
        field :ids, -> { Internal::Types::Array[String] }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
        field :q, -> { String }, optional: true, nullable: false
      end
    end
  end
end
