# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module EntityType
      extend Schematic::Internal::Types::Enum

      COMPANY = "company"
      USER = "user"
    end
  end
end
