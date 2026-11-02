# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module FeatureType
      extend Schematic::Internal::Types::Enum

      BOOLEAN = "boolean"
      EVENT = "event"
      LICENSE = "license"
      TRAIT = "trait"
    end
  end
end
