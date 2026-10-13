# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionDiffChangeType
      extend Schematic::Internal::Types::Enum

      ADDED = "added"
      CHANGED = "changed"
      REMOVED = "removed"
    end
  end
end
