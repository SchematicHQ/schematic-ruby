# frozen_string_literal: true

module Schematic
  module Types
    module EnvironmentType
      extend Schematic::Internal::Types::Enum

      DEVELOPMENT = "development"
      PRODUCTION = "production"
      STAGING = "staging"
    end
  end
end
