# frozen_string_literal: true

module Schematic
  module Types
    module EntitlementType
      extend Schematic::Internal::Types::Enum

      COMPANY_OVERRIDE = "company_override"
      PLAN_ENTITLEMENT = "plan_entitlement"
      UNKNOWN = "unknown"
    end
  end
end
