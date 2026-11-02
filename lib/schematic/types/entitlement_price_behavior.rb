# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module EntitlementPriceBehavior
      extend Schematic::Internal::Types::Enum

      CREDIT_BURNDOWN = "credit_burndown"
      OVERAGE = "overage"
      PAY_AS_YOU_GO = "pay_as_you_go"
      PAY_IN_ADVANCE = "pay_in_advance"
      TIER = "tier"
    end
  end
end
