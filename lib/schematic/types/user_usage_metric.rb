# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module UserUsageMetric
      extend Schematic::Internal::Types::Enum

      CREDITS = "credits"
      FEATURE = "feature"
    end
  end
end
