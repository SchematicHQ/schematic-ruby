# frozen_string_literal: true

module Schematic
  module Types
    module WebhookRequestType
      extend Schematic::Internal::Types::Enum

      SUBSCRIPTION_TRIAL_ENDED = "subscription.trial.ended"
      COMPANY_CREATED = "company.created"
      COMPANY_DELETED = "company.deleted"
      COMPANY_OVERRIDE_CREATED = "company.override.created"
      COMPANY_OVERRIDE_DELETED = "company.override.deleted"
      COMPANY_OVERRIDE_EXPIRED = "company.override.expired"
      COMPANY_OVERRIDE_UPDATED = "company.override.updated"
      COMPANY_PLAN_CHANGED = "company.plan_changed"
      COMPANY_SCHEDULED_DOWNGRADE = "company.scheduled_downgrade"
      COMPANY_UPDATED = "company.updated"
      CREDIT_LIMIT_REACHED = "credit.limit.reached"
      CREDIT_LIMIT_WARNING = "credit.limit.warning"
      ENTITLEMENT_LIMIT_REACHED = "entitlement.limit.reached"
      ENTITLEMENT_LIMIT_WARNING = "entitlement.limit.warning"
      ENTITLEMENT_SOFT_LIMIT_REACHED = "entitlement.soft_limit.reached"
      ENTITLEMENT_SOFT_LIMIT_WARNING = "entitlement.soft_limit.warning"
      ENTITLEMENT_TIER_LIMIT_REACHED = "entitlement.tier_limit.reached"
      ENTITLEMENT_TIER_LIMIT_WARNING = "entitlement.tier_limit.warning"
      FEATURE_CREATED = "feature.created"
      FEATURE_DELETED = "feature.deleted"
      FEATURE_UPDATED = "feature.updated"
      FLAG_CREATED = "flag.created"
      FLAG_DELETED = "flag.deleted"
      FLAG_RULES_UPDATED = "flag_rules.updated"
      FLAG_UPDATED = "flag.updated"
      PLAN_CREATED = "plan.created"
      PLAN_DELETED = "plan.deleted"
      PLAN_ENTITLEMENT_CREATED = "plan.entitlement.created"
      PLAN_ENTITLEMENT_DELETED = "plan.entitlement.deleted"
      PLAN_ENTITLEMENT_UPDATED = "plan.entitlement.updated"
      PLAN_UPDATED = "plan.updated"
      PLAN_VERSION_DELETED = "plan_version.deleted"
      RULE_DELETED = "rule.deleted"
      TEST_SEND = "test.send"
      USER_CREATED = "user.created"
      USER_DELETED = "user.deleted"
      USER_UPDATED = "user.updated"
      AUTO_TOPUP_HARD_FAILURE = "auto.topup.hard.failure"
      AUTO_TOPUP_RETRY_EXCEEDED = "auto.topup.retry.exceeded"
    end
  end
end
