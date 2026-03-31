# frozen_string_literal: true

module Schematic
  module Types
    module ConditionOperator
      extend Schematic::Internal::Types::Enum

      EQ = "eq"
      NE = "ne"
      GT = "gt"
      LT = "lt"
      GTE = "gte"
      LTE = "lte"
      IS_EMPTY = "is_empty"
      NOT_EMPTY = "not_empty"
    end
  end
end
