# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module CustomPlanBillingStatus
      extend Schematic::Internal::Types::Enum

      ACTIVE = "active"
      EXPIRED = "expired"
      PAID = "paid"
      PENDING = "pending"
    end
  end
end
