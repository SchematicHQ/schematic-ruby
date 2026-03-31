# frozen_string_literal: true

module Schematic
  module Types
    module CreateOrUpdateConditionRequestBodyConditionType
      extend Schematic::Internal::Types::Enum

      COMPANY = "company"
      METRIC = "metric"
      TRAIT = "trait"
      USER = "user"
      PLAN = "plan"
      BILLING_PRODUCT = "billing_product"
      BASE_PLAN = "base_plan"
    end
  end
end
