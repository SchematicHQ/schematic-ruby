# frozen_string_literal: true

module Schematic
  module Types
    module ChargeType
      extend Schematic::Internal::Types::Enum

      FREE = "free"
      ONE_TIME = "one_time"
      RECURRING = "recurring"
    end
  end
end
