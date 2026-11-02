# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module ConditionType
      extend Schematic::Internal::Types::Enum

      BASE_PLAN = "base_plan"
      BILLING_PRODUCT = "billing_product"
      COMPANY = "company"
      CREDIT = "credit"
      METRIC = "metric"
      PLAN = "plan"
      PLAN_VERSION = "plan_version"
      TRAIT = "trait"
      USER = "user"
    end
  end
end
