# frozen_string_literal: true

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
