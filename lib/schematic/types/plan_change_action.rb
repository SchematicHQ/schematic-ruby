# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanChangeAction
      extend Schematic::Internal::Types::Enum

      ACCESS_REINSTATED = "access_reinstated"
      ACCESS_REVOKED = "access_revoked"
      AMENDMENT = "amendment"
      CHECKOUT = "checkout"
      COMPANY_UPSERT = "company_upsert"
      FALLBACK_PLAN = "fallback_plan"
      INVOICE_PAST_DUE = "invoice_past_due"
      MANAGE_PLAN = "manage_plan"
      MIGRATION = "migration"
      PLAN_BILLING_PRODUCT_CHANGED = "plan_billing_product_changed"
      PLAN_DELETED = "plan_deleted"
      PLAN_TRAIT_CHANGE = "plan_trait_change"
      PLAN_VERSION_MIGRATION = "plan_version_migration"
      QUICKSTART = "quickstart"
      SUBSCRIPTION_CHANGE = "subscription_change"
    end
  end
end
