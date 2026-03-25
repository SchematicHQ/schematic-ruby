# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionMigrationStatus
      extend Schematic::Internal::Types::Enum

      COMPLETED = "completed"
      FAILED = "failed"
      IN_PROGRESS = "in_progress"
      PENDING = "pending"
    end
  end
end
