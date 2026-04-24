# frozen_string_literal: true

module Schematic
  module Types
    module ComparableOperator
      extend Schematic::Internal::Types::Enum

      EQ = "eq"
      GT = "gt"
      GTE = "gte"
      IS_EMPTY = "is_empty"
      LT = "lt"
      LTE = "lte"
      NOT_EMPTY = "not_empty"
      NE = "ne"
    end
  end
end
