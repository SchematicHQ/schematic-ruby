# frozen_string_literal: true

require_relative "../../schematic"

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
