# frozen_string_literal: true

module Schematic
  module Types
    module PlanChangeAmendmentStatus
      extend Schematic::Internal::Types::Enum

      APPLIED = "applied"
      CANCELLED = "cancelled"
      FAILED = "failed"
      SCHEDULED = "scheduled"
      SKIPPED = "skipped"
    end
  end
end
