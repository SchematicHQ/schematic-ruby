# frozen_string_literal: true

require_relative "../../schematic"

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
