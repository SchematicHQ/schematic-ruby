# frozen_string_literal: true

module Schematic
  module Types
    module RuleType
      extend Schematic::Internal::Types::Enum

      COMPANY_OVERRIDE = "company_override"
      COMPANY_OVERRIDE_USAGE_EXCEEDED = "company_override_usage_exceeded"
      DEFAULT = "default"
      GLOBAL_OVERRIDE = "global_override"
      PLAN_ENTITLEMENT = "plan_entitlement"
      PLAN_ENTITLEMENT_USAGE_EXCEEDED = "plan_entitlement_usage_exceeded"
      STANDARD = "standard"
    end
  end
end
