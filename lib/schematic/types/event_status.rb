# frozen_string_literal: true

module Schematic
  module Types
    module EventStatus
      extend Schematic::Internal::Types::Enum

      ENRICHED = "enriched"
      FAILED = "failed"
      PENDING = "pending"
      PROCESSED = "processed"
      UNKNOWN = "unknown"
    end
  end
end
