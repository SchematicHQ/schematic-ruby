# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ChargeTiming
      extend Schematic::Internal::Types::Enum

      IN_ADVANCE = "in_advance"
      IN_ARREARS = "in_arrears"
    end
  end
end
