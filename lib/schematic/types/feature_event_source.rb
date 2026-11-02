# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module FeatureEventSource
      extend Schematic::Internal::Types::Enum

      INFERENCE = "inference"
      TRACK = "track"
    end
  end
end
