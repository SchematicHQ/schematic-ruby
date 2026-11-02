# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanVersionCompanyMigrationStatus
      extend Schematic::Internal::Types::Enum

      CANCELLED = "cancelled"
      COMPLETED = "completed"
      FAILED = "failed"
      IN_PROGRESS = "in_progress"
      PENDING = "pending"
      SKIPPED = "skipped"
    end
  end
end
