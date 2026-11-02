# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ChargeType
      extend Schematic::Internal::Types::Enum

      FREE = "free"
      NONE = "none"
      ONE_TIME = "one_time"
      RECURRING = "recurring"
    end
  end
end
