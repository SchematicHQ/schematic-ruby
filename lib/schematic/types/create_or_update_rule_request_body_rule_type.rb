# frozen_string_literal: true

module Schematic
  module Types
    module CreateOrUpdateRuleRequestBodyRuleType
      extend Schematic::Internal::Types::Enum

      GLOBAL_OVERRIDE = "global_override"
      COMPANY_OVERRIDE = "company_override"
      PLAN_ENTITLEMENT = "plan_entitlement"
      STANDARD = "standard"
      DEFAULT = "default"
    end
  end
end
