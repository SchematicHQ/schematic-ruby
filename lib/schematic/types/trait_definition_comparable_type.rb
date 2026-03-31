# frozen_string_literal: true

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
