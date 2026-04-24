# frozen_string_literal: true

module Schematic
  module Types
    module AccountMemberPermission
      extend Schematic::Internal::Types::Enum

      BILLING_CREDITS_EDIT = "billing_credits_edit"
      COMPANIES_EDIT = "companies_edit"
      COMPANY_USERS_EDIT = "company_users_edit"
      COMPONENTS_EDIT = "components_edit"
      DATA_EXPORTS_EDIT = "data_exports_edit"
      FEATURES_EDIT = "features_edit"
      FLAG_RULES_EDIT = "flag_rules_edit"
      FLAGS_EDIT = "flags_edit"
      OVERRIDES_EDIT = "overrides_edit"
      PLAN_BILLING_EDIT = "plan_billing_edit"
      PLAN_ENTITLEMENTS_EDIT = "plan_entitlements_edit"
      PLAN_VERSIONS_EDIT = "plan_versions_edit"
      PLANS_EDIT = "plans_edit"
      WEBHOOKS_EDIT = "webhooks_edit"
      WEBHOOKS_REVEAL_SECRET = "webhooks_reveal_secret"
    end
  end
end
