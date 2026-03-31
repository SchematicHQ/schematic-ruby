# frozen_string_literal: true

module Schematic
  module Types
    module ScheduledCheckoutStatus
      extend Schematic::Internal::Types::Enum

      CANCELLED = "cancelled"
      ERROR = "error"
      EXECUTING = "executing"
      PENDING = "pending"
      SUCCESS = "success"
    end
  end
end
