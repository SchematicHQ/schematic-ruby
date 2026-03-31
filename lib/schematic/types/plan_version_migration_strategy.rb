# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionMigrationStrategy
      extend Schematic::Internal::Types::Enum

      IMMEDIATE = "immediate"
      LEAVE = "leave"
    end
  end
end
