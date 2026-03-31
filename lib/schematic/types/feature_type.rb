# frozen_string_literal: true

module Schematic
  module Types
    module FeatureType
      extend Schematic::Internal::Types::Enum

      BOOLEAN = "boolean"
      EVENT = "event"
      TRAIT = "trait"
    end
  end
end
