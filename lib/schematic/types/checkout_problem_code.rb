# frozen_string_literal: true

module Schematic
  module Types
    module CheckoutProblemCode
      extend Schematic::Internal::Types::Enum

      ADD_ON_CONFLICTS_WITH_PLAN = "add_on_conflicts_with_plan"
      ADD_ON_INTERVAL_MISMATCH = "add_on_interval_mismatch"
      ADD_ON_REQUIRES_BILLED_PLAN = "add_on_requires_billed_plan"
      ADD_ON_UNAVAILABLE = "add_on_unavailable"
      BILLING_CYCLE_ANCHOR_CONFLICTS_WITH_TRIAL = "billing_cycle_anchor_conflicts_with_trial"
      BILLING_CYCLE_ANCHOR_MUST_BE_FUTURE = "billing_cycle_anchor_must_be_future"
      BILLING_CYCLE_ANCHOR_NEEDS_NEW_SUBSCRIPTION = "billing_cycle_anchor_needs_new_subscription"
      BILLING_CYCLE_ANCHOR_WITHOUT_PLAN = "billing_cycle_anchor_without_plan"
      BILLING_START_DATE_MUST_BE_PAST = "billing_start_date_must_be_past"
      BILLING_START_DATE_NEEDS_NEW_SUBSCRIPTION = "billing_start_date_needs_new_subscription"
      BILLING_START_DATE_NEEDS_RENEWAL_DATE = "billing_start_date_needs_renewal_date"
      BILLING_START_DATE_NOT_BEFORE_RENEWAL_DATE = "billing_start_date_not_before_renewal_date"
      BILLING_START_DATE_TOO_FAR_IN_PAST = "billing_start_date_too_far_in_past"
      CREDIT_BUNDLE_INCOMPATIBLE = "credit_bundle_incompatible"
      CREDIT_BUNDLE_UNAVAILABLE = "credit_bundle_unavailable"
      CREDIT_BUNDLES_ACTIVATE_ON_PAYMENT = "credit_bundles_activate_on_payment"
      CURRENCY_MISMATCH = "currency_mismatch"
      CUSTOM_FIELD_REQUIRED = "custom_field_required"
      DISCOUNT_INELIGIBLE = "discount_ineligible"
      DOWNGRADE_NOT_PERMITTED = "downgrade_not_permitted"
      FREE_FIRST_PERIOD_ACTIVATES_ON_PAYMENT = "free_first_period_activates_on_payment"
      INVOICE_EMAIL_REQUIRED = "invoice_email_required"
      INVOICED_SUBSCRIPTION_CONFLICTS_WITH_TRIAL = "invoiced_subscription_conflicts_with_trial"
      INVOICED_SUBSCRIPTION_NEEDS_NEW_SUBSCRIPTION = "invoiced_subscription_needs_new_subscription"
      INVOICED_SUBSCRIPTION_REQUIRES_PLAN = "invoiced_subscription_requires_plan"
      OPT_IN_REQUIRED = "opt_in_required"
      PAY_IN_ADVANCE_PRICE_INVALID = "pay_in_advance_price_invalid"
      PAY_IN_ADVANCE_REQUIRED = "pay_in_advance_required"
      PAYMENT_METHOD_REQUIRED = "payment_method_required"
      PLAN_NOT_TRIALABLE = "plan_not_trialable"
      PLAN_UNAVAILABLE = "plan_unavailable"
      PRICE_UNAVAILABLE = "price_unavailable"
      PRORATE_FIRST_PERIOD_WITHOUT_ANCHOR = "prorate_first_period_without_anchor"
      PROVIDER_REJECTED = "provider_rejected"
      SCHEDULED_CHANGE_BLOCKS_PURCHASE = "scheduled_change_blocks_purchase"
      SCHEDULED_CHANGE_PENDING = "scheduled_change_pending"
      SELECTION_INVALID = "selection_invalid"
      SUBSCRIPTION_CURRENCY_CHANGE = "subscription_currency_change"
      TRIAL_END_MUST_BE_FUTURE = "trial_end_must_be_future"
      TRIAL_END_TOO_FAR = "trial_end_too_far"
      TRIAL_EXCLUDES_ADD_ONS = "trial_excludes_add_ons"
      TRIAL_EXCLUDES_USAGE_BASED = "trial_excludes_usage_based"
      USAGE_PRICE_MISSING_FOR_INTERVAL = "usage_price_missing_for_interval"
      USAGE_OVER_LIMIT = "usage_over_limit"
    end
  end
end
