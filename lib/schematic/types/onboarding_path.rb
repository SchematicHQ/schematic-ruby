# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module OnboardingPath
      extend Schematic::Internal::Types::Enum

      AGENT = "agent"
      APP = "app"
    end
  end
end
