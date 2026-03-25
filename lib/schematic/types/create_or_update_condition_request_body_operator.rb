# frozen_string_literal: true

module Schematic
  module Types
    module CreateOrUpdateConditionRequestBodyOperator
      extend Schematic::Internal::Types::Enum

      EQ = "eq"
      NE = "ne"
      GT = "gt"
      GTE = "gte"
      LT = "lt"
      LTE = "lte"
      IS_EMPTY = "is_empty"
      NOT_EMPTY = "not_empty"
    end
  end
end
