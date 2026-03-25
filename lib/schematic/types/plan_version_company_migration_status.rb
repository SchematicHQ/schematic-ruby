# frozen_string_literal: true

module Schematic
  module Types
    module PlanVersionCompanyMigrationStatus
      extend Schematic::Internal::Types::Enum

      COMPLETED = "completed"
      FAILED = "failed"
      IN_PROGRESS = "in_progress"
      PENDING = "pending"
      SKIPPED = "skipped"
    end
  end
end
