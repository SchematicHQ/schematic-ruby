# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module TraitDefinitionComparableType
      extend Schematic::Internal::Types::Enum

      BOOL = "bool"
      DATE = "date"
      INT = "int"
      STRING = "string"
    end
  end
end
