# frozen_string_literal: true

require "json"
require "net/http"
require "securerandom"
require "time"

require_relative "schematic/internal/json/serializable"
require_relative "schematic/internal/types/type"
require_relative "schematic/internal/types/utils"
require_relative "schematic/internal/types/union"
require_relative "schematic/internal/errors/constraint_error"
require_relative "schematic/internal/errors/type_error"
require_relative "schematic/internal/http/base_request"
require_relative "schematic/internal/json/request"
require_relative "schematic/internal/http/raw_client"
require_relative "schematic/internal/multipart/multipart_encoder"
require_relative "schematic/internal/multipart/multipart_form_data_part"
require_relative "schematic/internal/multipart/multipart_form_data"
require_relative "schematic/internal/multipart/multipart_request"
require_relative "schematic/internal/types/model/field"
require_relative "schematic/internal/types/model"
require_relative "schematic/internal/types/array"
require_relative "schematic/internal/types/boolean"
require_relative "schematic/internal/types/enum"
require_relative "schematic/internal/types/hash"
require_relative "schematic/internal/types/unknown"
require_relative "schematic/errors/api_error"
require_relative "schematic/errors/response_error"
require_relative "schematic/errors/client_error"
require_relative "schematic/errors/redirect_error"
require_relative "schematic/errors/server_error"
require_relative "schematic/errors/timeout_error"
require_relative "schematic/internal/iterators/item_iterator"
require_relative "schematic/internal/iterators/cursor_item_iterator"
require_relative "schematic/internal/iterators/offset_item_iterator"
require_relative "schematic/internal/iterators/cursor_page_iterator"
require_relative "schematic/internal/iterators/offset_page_iterator"
require_relative "schematic/errors/connection_error"
require_relative "schematic/client"
require_relative "schematic/accounts/client"
require_relative "schematic/accounts/types/list_account_members_request"
require_relative "schematic/accounts/types/count_account_members_request"
require_relative "schematic/accounts/types/list_api_keys_request"
require_relative "schematic/accounts/types/count_api_keys_request"
require_relative "schematic/accounts/types/list_audit_logs_request"
require_relative "schematic/accounts/types/count_audit_logs_request"
require_relative "schematic/accounts/types/list_environments_request"
require_relative "schematic/accounts/types/update_onboarding_state_request_body"
require_relative "schematic/billing/client"
require_relative "schematic/billing/types/list_coupons_request"
require_relative "schematic/billing/types/create_coupon_request_body"
require_relative "schematic/billing/types/create_billing_customer_request_body"
require_relative "schematic/billing/types/list_customers_with_subscriptions_request"
require_relative "schematic/billing/types/count_customers_request"
require_relative "schematic/billing/types/list_invoices_request"
require_relative "schematic/billing/types/create_invoice_request_body"
require_relative "schematic/billing/types/list_meters_request"
require_relative "schematic/billing/types/create_meter_request_body"
require_relative "schematic/billing/types/list_payment_methods_request"
require_relative "schematic/billing/types/create_payment_method_request_body"
require_relative "schematic/billing/types/list_billing_prices_request"
require_relative "schematic/billing/types/create_billing_price_request_body"
require_relative "schematic/billing/types/list_billing_product_prices_request"
require_relative "schematic/billing/types/create_billing_product_request_body"
require_relative "schematic/billing/types/list_billing_products_request"
require_relative "schematic/billing/types/count_billing_products_request"
require_relative "schematic/billing/types/list_company_billing_profiles_request"
require_relative "schematic/billing/types/update_company_billing_profile_request_body"
require_relative "schematic/billing/types/update_billing_settings_request_body"
require_relative "schematic/billing/types/create_billing_subscription_request_body"
require_relative "schematic/billing/types/list_billing_invoices_request"
require_relative "schematic/billing/types/mark_invoice_paid_request_body"
require_relative "schematic/billing/types/count_billing_invoices_request"
require_relative "schematic/credits/client"
require_relative "schematic/credits/types/list_billing_credits_request"
require_relative "schematic/credits/types/create_billing_credit_request_body"
require_relative "schematic/credits/types/update_billing_credit_request_body"
require_relative "schematic/credits/types/list_company_credit_balances_request"
require_relative "schematic/credits/types/get_credit_balance_time_series_request"
require_relative "schematic/credits/types/list_credit_bundles_request"
require_relative "schematic/credits/types/create_credit_bundle_request_body"
require_relative "schematic/credits/types/update_credit_bundle_details_request_body"
require_relative "schematic/credits/types/count_credit_bundles_request"
require_relative "schematic/credits/types/count_billing_credits_request"
require_relative "schematic/credits/types/zero_out_grant_request_body"
require_relative "schematic/credits/types/create_company_credit_grant"
require_relative "schematic/credits/types/count_company_grants_request"
require_relative "schematic/credits/types/list_company_grants_request"
require_relative "schematic/credits/types/count_billing_credits_grants_request"
require_relative "schematic/credits/types/list_grants_for_credit_request"
require_relative "schematic/credits/types/acquire_credit_lease_request_body"
require_relative "schematic/credits/types/extend_credit_lease_request_body"
require_relative "schematic/credits/types/list_billing_plan_credit_grants_request"
require_relative "schematic/credits/types/delete_billing_plan_credit_grant_request"
require_relative "schematic/credits/types/count_billing_plan_credit_grants_request"
require_relative "schematic/credits/types/reserve_credits_request_body"
require_relative "schematic/credits/types/list_credit_spend_policies_request"
require_relative "schematic/credits/types/create_credit_spend_policy_request_body"
require_relative "schematic/credits/types/update_credit_spend_policy_request_body"
require_relative "schematic/credits/types/count_credit_spend_policies_request"
require_relative "schematic/credits/types/get_credit_spend_policy_usage_request"
require_relative "schematic/credits/types/list_credit_event_ledger_request"
require_relative "schematic/credits/types/count_credit_event_ledger_request"
require_relative "schematic/catalogs/client"
require_relative "schematic/catalogs/types/list_catalogs_request"
require_relative "schematic/catalogs/types/create_catalog_request_body"
require_relative "schematic/catalogs/types/update_catalog_request_body"
require_relative "schematic/catalogs/types/update_catalog_configuration_request_body"
require_relative "schematic/checkout/client"
require_relative "schematic/checkout/types/checkout_data_request_body"
require_relative "schematic/checkout/types/update_company_billing_details_request_body"
require_relative "schematic/checkout/types/cancel_subscription_request"
require_relative "schematic/checkout/types/update_trial_end_request_body"
require_relative "schematic/companies/client"
require_relative "schematic/companies/types/list_companies_request"
require_relative "schematic/companies/types/delete_company_request"
require_relative "schematic/companies/types/get_company_inference_cost_request"
require_relative "schematic/companies/types/count_companies_request"
require_relative "schematic/companies/types/lookup_company_request"
require_relative "schematic/companies/types/get_company_billing_entity_request"
require_relative "schematic/companies/types/get_billing_entity_child_subscriptions_request"
require_relative "schematic/companies/types/list_company_memberships_request"
require_relative "schematic/companies/types/get_or_create_company_membership_request_body"
require_relative "schematic/companies/types/get_active_company_subscription_request"
require_relative "schematic/companies/types/list_entity_key_definitions_request"
require_relative "schematic/companies/types/count_entity_key_definitions_request"
require_relative "schematic/companies/types/count_entity_keys_request"
require_relative "schematic/companies/types/list_entity_trait_definitions_request"
require_relative "schematic/companies/types/create_entity_trait_definition_request_body"
require_relative "schematic/companies/types/update_entity_trait_definition_request_body"
require_relative "schematic/companies/types/count_entity_trait_definitions_request"
require_relative "schematic/companies/types/get_entity_trait_values_request"
require_relative "schematic/companies/types/count_entity_traits_request"
require_relative "schematic/companies/types/list_plan_changes_request"
require_relative "schematic/companies/types/list_plan_traits_request"
require_relative "schematic/companies/types/update_plan_trait_bulk_request_body"
require_relative "schematic/companies/types/count_plan_traits_request"
require_relative "schematic/companies/types/list_users_request"
require_relative "schematic/companies/types/count_users_request"
require_relative "schematic/companies/types/lookup_user_request"
require_relative "schematic/entitlements/client"
require_relative "schematic/entitlements/types/list_company_overrides_request"
require_relative "schematic/entitlements/types/create_company_override_request_body"
require_relative "schematic/entitlements/types/update_company_override_request_body"
require_relative "schematic/entitlements/types/count_company_overrides_request"
require_relative "schematic/entitlements/types/list_feature_companies_request"
require_relative "schematic/entitlements/types/count_feature_companies_request"
require_relative "schematic/entitlements/types/list_feature_usage_request"
require_relative "schematic/entitlements/types/list_feature_usage_history_request"
require_relative "schematic/entitlements/types/get_feature_usage_time_series_request"
require_relative "schematic/entitlements/types/count_feature_usage_request"
require_relative "schematic/entitlements/types/list_feature_users_request"
require_relative "schematic/entitlements/types/count_feature_users_request"
require_relative "schematic/entitlements/types/list_plan_entitlements_request"
require_relative "schematic/entitlements/types/create_plan_entitlement_request_body"
require_relative "schematic/entitlements/types/update_plan_entitlement_request_body"
require_relative "schematic/entitlements/types/create_billing_linked_plan_entitlement_request_body"
require_relative "schematic/entitlements/types/count_plan_entitlements_request"
require_relative "schematic/entitlements/types/duplicate_plan_entitlements_request_body"
require_relative "schematic/entitlements/types/get_feature_usage_by_company_request"
require_relative "schematic/entitlements/types/get_user_usage_by_company_request"
require_relative "schematic/entitlements/types/get_company_user_usage_metrics_request"
require_relative "schematic/entitlements/types/list_company_user_usage_request"
require_relative "schematic/entitlements/types/count_company_user_usage_request"
require_relative "schematic/entitlements/types/get_user_usage_detail_request"
require_relative "schematic/plans/client"
require_relative "schematic/plans/types/update_company_plans_request_body"
require_relative "schematic/plans/types/list_custom_plan_billings_request"
require_relative "schematic/plans/types/retry_custom_plan_billing_request_body"
require_relative "schematic/plans/types/create_custom_plan_request_body"
require_relative "schematic/plans/types/list_plans_request"
require_relative "schematic/plans/types/get_plan_request"
require_relative "schematic/plans/types/create_billing_linked_plan_request_body"
require_relative "schematic/plans/types/list_billing_product_match_companies_request"
require_relative "schematic/plans/types/count_billing_product_match_companies_request"
require_relative "schematic/plans/types/count_plans_request"
require_relative "schematic/plans/types/list_plan_issues_request"
require_relative "schematic/plans/types/delete_plan_version_request"
require_relative "schematic/plans/types/get_plan_version_diff_request"
require_relative "schematic/components/client"
require_relative "schematic/components/types/list_components_request"
require_relative "schematic/components/types/create_component_request_body"
require_relative "schematic/components/types/update_component_request_body"
require_relative "schematic/components/types/bind_catalog_request_body"
require_relative "schematic/components/types/count_components_request"
require_relative "schematic/components/types/preview_component_data_request"
require_relative "schematic/planbundle/client"
require_relative "schematic/planbundle/types/create_custom_plan_bundle_request_body"
require_relative "schematic/planbundle/types/create_plan_bundle_request_body"
require_relative "schematic/planbundle/types/update_plan_bundle_request_body"
require_relative "schematic/dataexports/client"
require_relative "schematic/dataexports/types/list_data_exports_request"
require_relative "schematic/dataexports/types/create_data_export_request_body"
require_relative "schematic/events/client"
require_relative "schematic/events/types/create_event_batch_request_body"
require_relative "schematic/events/types/get_event_summaries_request"
require_relative "schematic/events/types/list_events_request"
require_relative "schematic/events/types/upsert_otlp_environment_settings_request_body"
require_relative "schematic/features/client"
require_relative "schematic/features/types/list_features_request"
require_relative "schematic/features/types/create_feature_request_body"
require_relative "schematic/features/types/update_feature_request_body"
require_relative "schematic/features/types/create_billing_linked_feature_request_body"
require_relative "schematic/features/types/count_features_request"
require_relative "schematic/features/types/list_flags_request"
require_relative "schematic/features/types/update_flag_rules_request_body"
require_relative "schematic/features/types/check_and_reserve_flag_request_body"
require_relative "schematic/features/types/check_flags_bulk_request_body"
require_relative "schematic/features/types/count_flags_request"
require_relative "schematic/insights/client"
require_relative "schematic/insights/types/get_activity_request"
require_relative "schematic/insights/types/get_environment_feature_usage_time_series_request"
require_relative "schematic/insights/types/get_plan_growth_request"
require_relative "schematic/insights/types/get_top_features_by_usage_request"
require_relative "schematic/insights/types/get_environment_trait_usage_time_series_request"
require_relative "schematic/integrationsapi/client"
require_relative "schematic/integrationsapi/types/list_integrations_request"
require_relative "schematic/integrationsapi/types/start_data_import_request_body"
require_relative "schematic/integrationsapi/types/claim_stripe_sandbox_keys_request_body"
require_relative "schematic/integrationsapi/types/install_stripe_sandbox_request_body"
require_relative "schematic/licenses/client"
require_relative "schematic/licenses/types/list_licenses_request"
require_relative "schematic/licenses/types/count_licenses_request"
require_relative "schematic/plangroups/client"
require_relative "schematic/plangroups/types/get_plan_group_request"
require_relative "schematic/plangroups/types/create_plan_group_request_body"
require_relative "schematic/plangroups/types/update_plan_group_request_body"
require_relative "schematic/planmigrations/client"
require_relative "schematic/planmigrations/types/list_company_migrations_request"
require_relative "schematic/planmigrations/types/count_company_migrations_request"
require_relative "schematic/planmigrations/types/list_migrations_request"
require_relative "schematic/planmigrations/types/create_migration_input"
require_relative "schematic/planmigrations/types/complete_migration_now_request_body"
require_relative "schematic/planmigrations/types/retry_migration_request_body"
require_relative "schematic/planmigrations/types/count_migrations_request"
require_relative "schematic/planmigrations/types/preview_migration_request_body"
require_relative "schematic/componentspublic/client"
require_relative "schematic/scheduledcheckout/client"
require_relative "schematic/scheduledcheckout/types/list_scheduled_checkouts_request"
require_relative "schematic/scheduledcheckout/types/create_scheduled_checkout_request"
require_relative "schematic/scheduledcheckout/types/update_scheduled_checkout_request"
require_relative "schematic/accesstokens/client"
require_relative "schematic/accesstokens/types/issue_temporary_access_token_request_body"
require_relative "schematic/webhooks/client"
require_relative "schematic/webhooks/types/list_webhook_events_request"
require_relative "schematic/webhooks/types/count_webhook_events_request"
require_relative "schematic/webhooks/types/list_webhooks_request"
require_relative "schematic/webhooks/types/create_webhook_request_body"
require_relative "schematic/webhooks/types/update_webhook_request_body"
require_relative "schematic/webhooks/types/test_webhook_request_body"
require_relative "schematic/webhooks/types/count_webhooks_request"
require_relative "schematic/environment"

module Schematic
  module Types
    autoload :AccountMemberRole, ::File.join(__dir__, "schematic/types/account_member_role")
    autoload :AccountMemberPermission, ::File.join(__dir__, "schematic/types/account_member_permission")
    autoload :AccountMemberResponseData, ::File.join(__dir__, "schematic/types/account_member_response_data")
    autoload :CountResponse, ::File.join(__dir__, "schematic/types/count_response")
    autoload :IntegrationState, ::File.join(__dir__, "schematic/types/integration_state")
    autoload :IntegrationType, ::File.join(__dir__, "schematic/types/integration_type")
    autoload :ApiKeyIntegrationResponseData, ::File.join(__dir__, "schematic/types/api_key_integration_response_data")
    autoload :ApiKeyScope, ::File.join(__dir__, "schematic/types/api_key_scope")
    autoload :EnvironmentType, ::File.join(__dir__, "schematic/types/environment_type")
    autoload :EnvironmentResponseData, ::File.join(__dir__, "schematic/types/environment_response_data")
    autoload :ApiKeyResponseData, ::File.join(__dir__, "schematic/types/api_key_response_data")
    autoload :ActorType, ::File.join(__dir__, "schematic/types/actor_type")
    autoload :AuditLogCompanyResponseData, ::File.join(__dir__, "schematic/types/audit_log_company_response_data")
    autoload :AuditLogListResponseData, ::File.join(__dir__, "schematic/types/audit_log_list_response_data")
    autoload :AuditLogResponseData, ::File.join(__dir__, "schematic/types/audit_log_response_data")
    autoload :OnboardingMilestone, ::File.join(__dir__, "schematic/types/onboarding_milestone")
    autoload :OnboardingRequirement, ::File.join(__dir__, "schematic/types/onboarding_requirement")
    autoload :OnboardingMilestoneView, ::File.join(__dir__, "schematic/types/onboarding_milestone_view")
    autoload :OnboardingPath, ::File.join(__dir__, "schematic/types/onboarding_path")
    autoload :OnboardingRequirementStatus, ::File.join(__dir__, "schematic/types/onboarding_requirement_status")
    autoload :OnboardingRequirementView, ::File.join(__dir__, "schematic/types/onboarding_requirement_view")
    autoload :OnboardingRoadmapView, ::File.join(__dir__, "schematic/types/onboarding_roadmap_view")
    autoload :OnboardingStripeImport, ::File.join(__dir__, "schematic/types/onboarding_stripe_import")
    autoload :OnboardingTrack, ::File.join(__dir__, "schematic/types/onboarding_track")
    autoload :SlackConnectInviteStatus, ::File.join(__dir__, "schematic/types/slack_connect_invite_status")
    autoload :SlackConnectInviteView, ::File.join(__dir__, "schematic/types/slack_connect_invite_view")
    autoload :GetOnboardingStateResp, ::File.join(__dir__, "schematic/types/get_onboarding_state_resp")
    autoload :QuickstartResp, ::File.join(__dir__, "schematic/types/quickstart_resp")
    autoload :WhoAmIResponseData, ::File.join(__dir__, "schematic/types/who_am_i_response_data")
    autoload :BillingProviderType, ::File.join(__dir__, "schematic/types/billing_provider_type")
    autoload :Currency, ::File.join(__dir__, "schematic/types/currency")
    autoload :BillingCouponResponseData, ::File.join(__dir__, "schematic/types/billing_coupon_response_data")
    autoload :DeleteResponse, ::File.join(__dir__, "schematic/types/delete_response")
    autoload :BillingCustomerResponseData, ::File.join(__dir__, "schematic/types/billing_customer_response_data")
    autoload :BillingCustomerSubscription, ::File.join(__dir__, "schematic/types/billing_customer_subscription")
    autoload :BillingCustomerWithSubscriptionsResponseData, ::File.join(__dir__, "schematic/types/billing_customer_with_subscriptions_response_data")
    autoload :InvoiceStatus, ::File.join(__dir__, "schematic/types/invoice_status")
    autoload :InvoiceResponseData, ::File.join(__dir__, "schematic/types/invoice_response_data")
    autoload :BillingMeterResponseData, ::File.join(__dir__, "schematic/types/billing_meter_response_data")
    autoload :PaymentMethodResponseData, ::File.join(__dir__, "schematic/types/payment_method_response_data")
    autoload :BillingPriceUsageType, ::File.join(__dir__, "schematic/types/billing_price_usage_type")
    autoload :BillingTiersMode, ::File.join(__dir__, "schematic/types/billing_tiers_mode")
    autoload :BillingPriceScheme, ::File.join(__dir__, "schematic/types/billing_price_scheme")
    autoload :BillingProductPriceInterval, ::File.join(__dir__, "schematic/types/billing_product_price_interval")
    autoload :BillingProductPriceTierResponseData, ::File.join(__dir__, "schematic/types/billing_product_price_tier_response_data")
    autoload :BillingPriceView, ::File.join(__dir__, "schematic/types/billing_price_view")
    autoload :BillingPriceResponseData, ::File.join(__dir__, "schematic/types/billing_price_response_data")
    autoload :BillingProductResponseData, ::File.join(__dir__, "schematic/types/billing_product_response_data")
    autoload :BillingProductDetailResponseData, ::File.join(__dir__, "schematic/types/billing_product_detail_response_data")
    autoload :BillingCollectionMethod, ::File.join(__dir__, "schematic/types/billing_collection_method")
    autoload :Collector, ::File.join(__dir__, "schematic/types/collector")
    autoload :PaymentGating, ::File.join(__dir__, "schematic/types/payment_gating")
    autoload :ProrationBehavior, ::File.join(__dir__, "schematic/types/proration_behavior")
    autoload :CompanyBillingProfileResponseData, ::File.join(__dir__, "schematic/types/company_billing_profile_response_data")
    autoload :BillingSettingsResponseData, ::File.join(__dir__, "schematic/types/billing_settings_response_data")
    autoload :BillingSubscriptionTrialEndSetting, ::File.join(__dir__, "schematic/types/billing_subscription_trial_end_setting")
    autoload :BillingSubscriptionResponseData, ::File.join(__dir__, "schematic/types/billing_subscription_response_data")
    autoload :BillingInvoiceAddressResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_address_response_data")
    autoload :TaxIdType, ::File.join(__dir__, "schematic/types/tax_id_type")
    autoload :BillingInvoiceTaxIdResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_tax_id_response_data")
    autoload :BillingInvoiceBillingDetailsResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_billing_details_response_data")
    autoload :BillingInvoiceTermsResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_terms_response_data")
    autoload :ChargeTiming, ::File.join(__dir__, "schematic/types/charge_timing")
    autoload :LineKind, ::File.join(__dir__, "schematic/types/line_kind")
    autoload :PlanType, ::File.join(__dir__, "schematic/types/plan_type")
    autoload :BillingNativeSubscriptionLineResponseData, ::File.join(__dir__, "schematic/types/billing_native_subscription_line_response_data")
    autoload :SubscriptionChangeAction, ::File.join(__dir__, "schematic/types/subscription_change_action")
    autoload :BillingNativeSubscriptionChangeResponseData, ::File.join(__dir__, "schematic/types/billing_native_subscription_change_response_data")
    autoload :InvoiceLineKind, ::File.join(__dir__, "schematic/types/invoice_line_kind")
    autoload :BillingStatementLineResponseData, ::File.join(__dir__, "schematic/types/billing_statement_line_response_data")
    autoload :BillingStatementResponseData, ::File.join(__dir__, "schematic/types/billing_statement_response_data")
    autoload :SubscriptionStatus, ::File.join(__dir__, "schematic/types/subscription_status")
    autoload :BillingNativeSubscriptionResponseData, ::File.join(__dir__, "schematic/types/billing_native_subscription_response_data")
    autoload :InvoiceDocumentState, ::File.join(__dir__, "schematic/types/invoice_document_state")
    autoload :InvoiceCollectionState, ::File.join(__dir__, "schematic/types/invoice_collection_state")
    autoload :BillingInvoiceResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_response_data")
    autoload :BillingInvoiceLineResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_line_response_data")
    autoload :BillingInvoiceSettlementResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_settlement_response_data")
    autoload :BillingInvoiceDetailResponseData, ::File.join(__dir__, "schematic/types/billing_invoice_detail_response_data")
    autoload :BillingCreditBurnStrategy, ::File.join(__dir__, "schematic/types/billing_credit_burn_strategy")
    autoload :BillingCreditExpiryUnit, ::File.join(__dir__, "schematic/types/billing_credit_expiry_unit")
    autoload :BillingCreditLedgerAuthority, ::File.join(__dir__, "schematic/types/billing_credit_ledger_authority")
    autoload :BillingCreditRolloverPolicy, ::File.join(__dir__, "schematic/types/billing_credit_rollover_policy")
    autoload :CreditCurrencyPriceResponseData, ::File.join(__dir__, "schematic/types/credit_currency_price_response_data")
    autoload :BillingCreditResponseData, ::File.join(__dir__, "schematic/types/billing_credit_response_data")
    autoload :CompanyCreditBalanceResponseData, ::File.join(__dir__, "schematic/types/company_credit_balance_response_data")
    autoload :BillingCreditGrantReason, ::File.join(__dir__, "schematic/types/billing_credit_grant_reason")
    autoload :BillingCreditGrantZeroedOutReason, ::File.join(__dir__, "schematic/types/billing_credit_grant_zeroed_out_reason")
    autoload :CreditEventType, ::File.join(__dir__, "schematic/types/credit_event_type")
    autoload :CreditBalanceEventResponseData, ::File.join(__dir__, "schematic/types/credit_balance_event_response_data")
    autoload :CreditBalanceFeatureConsumptionResponseData, ::File.join(__dir__, "schematic/types/credit_balance_feature_consumption_response_data")
    autoload :CreditBalancePointResponseData, ::File.join(__dir__, "schematic/types/credit_balance_point_response_data")
    autoload :CreditBalanceTimeSeriesResponseData, ::File.join(__dir__, "schematic/types/credit_balance_time_series_response_data")
    autoload :BillingCreditBundleStatus, ::File.join(__dir__, "schematic/types/billing_credit_bundle_status")
    autoload :BillingCreditBundleType, ::File.join(__dir__, "schematic/types/billing_credit_bundle_type")
    autoload :BillingCreditExpiryType, ::File.join(__dir__, "schematic/types/billing_credit_expiry_type")
    autoload :CreditBundleCurrencyPriceResponseData, ::File.join(__dir__, "schematic/types/credit_bundle_currency_price_response_data")
    autoload :BillingCreditBundleResponseData, ::File.join(__dir__, "schematic/types/billing_credit_bundle_response_data")
    autoload :BillingPlanCreditGrantResetCadence, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_reset_cadence")
    autoload :CreditTransferResponseData, ::File.join(__dir__, "schematic/types/credit_transfer_response_data")
    autoload :BillingCreditGrantResponseData, ::File.join(__dir__, "schematic/types/billing_credit_grant_response_data")
    autoload :CreditGrantSortOrder, ::File.join(__dir__, "schematic/types/credit_grant_sort_order")
    autoload :SortDirection, ::File.join(__dir__, "schematic/types/sort_direction")
    autoload :CreditLeaseResponseData, ::File.join(__dir__, "schematic/types/credit_lease_response_data")
    autoload :BillingArrearsAnchor, ::File.join(__dir__, "schematic/types/billing_arrears_anchor")
    autoload :BillingArrearsCadence, ::File.join(__dir__, "schematic/types/billing_arrears_cadence")
    autoload :BillingCreditAutoTopupAvailability, ::File.join(__dir__, "schematic/types/billing_credit_auto_topup_availability")
    autoload :BillingPlanCreditGrantBillingMode, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_billing_mode")
    autoload :BillingPlanCreditGrantPriceTierResponseData, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_price_tier_response_data")
    autoload :BillingPlanCreditGrantResetStart, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_reset_start")
    autoload :BillingPlanCreditGrantResetType, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_reset_type")
    autoload :BillingPlanCreditGrantWarningTierResponseData, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_warning_tier_response_data")
    autoload :PlanCreditGrantScaling, ::File.join(__dir__, "schematic/types/plan_credit_grant_scaling")
    autoload :PreviewObjectResponseData, ::File.join(__dir__, "schematic/types/preview_object_response_data")
    autoload :BillingPlanCreditGrantResponseData, ::File.join(__dir__, "schematic/types/billing_plan_credit_grant_response_data")
    autoload :CreditReservationResponseData, ::File.join(__dir__, "schematic/types/credit_reservation_response_data")
    autoload :CreditSpendPolicyScope, ::File.join(__dir__, "schematic/types/credit_spend_policy_scope")
    autoload :CreditSpendWindowUnit, ::File.join(__dir__, "schematic/types/credit_spend_window_unit")
    autoload :CreditSpendPolicyResponseData, ::File.join(__dir__, "schematic/types/credit_spend_policy_response_data")
    autoload :BillingCreditLedgerResponseData, ::File.join(__dir__, "schematic/types/billing_credit_ledger_response_data")
    autoload :CompanyLedgerResponseData, ::File.join(__dir__, "schematic/types/company_ledger_response_data")
    autoload :CreditBurnBreakdownLine, ::File.join(__dir__, "schematic/types/credit_burn_breakdown_line")
    autoload :CreditLedgerEntryKind, ::File.join(__dir__, "schematic/types/credit_ledger_entry_kind")
    autoload :CreditLedgerSourceType, ::File.join(__dir__, "schematic/types/credit_ledger_source_type")
    autoload :CreditTransferReason, ::File.join(__dir__, "schematic/types/credit_transfer_reason")
    autoload :CreditUsageReason, ::File.join(__dir__, "schematic/types/credit_usage_reason")
    autoload :FeatureLedgerResponseData, ::File.join(__dir__, "schematic/types/feature_ledger_response_data")
    autoload :CreditEventLedgerResponseData, ::File.join(__dir__, "schematic/types/credit_event_ledger_response_data")
    autoload :CatalogResponseData, ::File.join(__dir__, "schematic/types/catalog_response_data")
    autoload :BillingLinkedResourceResponseData, ::File.join(__dir__, "schematic/types/billing_linked_resource_response_data")
    autoload :BillingStrategy, ::File.join(__dir__, "schematic/types/billing_strategy")
    autoload :CatalogConfigOrderedBundleResponseData, ::File.join(__dir__, "schematic/types/catalog_config_ordered_bundle_response_data")
    autoload :CatalogConfigOrderedEntitlementResponseData, ::File.join(__dir__, "schematic/types/catalog_config_ordered_entitlement_response_data")
    autoload :CatalogConfigPlanCreditResponseData, ::File.join(__dir__, "schematic/types/catalog_config_plan_credit_response_data")
    autoload :CatalogConfigOrderedPlanResponseData, ::File.join(__dir__, "schematic/types/catalog_config_ordered_plan_response_data")
    autoload :ChargeType, ::File.join(__dir__, "schematic/types/charge_type")
    autoload :ComparableOperator, ::File.join(__dir__, "schematic/types/comparable_operator")
    autoload :ConditionType, ::File.join(__dir__, "schematic/types/condition_type")
    autoload :CustomPlanViewConfigResponseData, ::File.join(__dir__, "schematic/types/custom_plan_view_config_response_data")
    autoload :EntitlementCurrencyPricesResponseData, ::File.join(__dir__, "schematic/types/entitlement_currency_prices_response_data")
    autoload :EntitlementPriceBehavior, ::File.join(__dir__, "schematic/types/entitlement_price_behavior")
    autoload :EntitlementValueType, ::File.join(__dir__, "schematic/types/entitlement_value_type")
    autoload :EntityType, ::File.join(__dir__, "schematic/types/entity_type")
    autoload :TraitType, ::File.join(__dir__, "schematic/types/trait_type")
    autoload :EntityTraitDefinitionResponseData, ::File.join(__dir__, "schematic/types/entity_trait_definition_response_data")
    autoload :EventSummaryResponseData, ::File.join(__dir__, "schematic/types/event_summary_response_data")
    autoload :FeatureEventSource, ::File.join(__dir__, "schematic/types/feature_event_source")
    autoload :FeatureLifecyclePhase, ::File.join(__dir__, "schematic/types/feature_lifecycle_phase")
    autoload :FeatureType, ::File.join(__dir__, "schematic/types/feature_type")
    autoload :FeatureResponseData, ::File.join(__dir__, "schematic/types/feature_response_data")
    autoload :FlagType, ::File.join(__dir__, "schematic/types/flag_type")
    autoload :MetricPeriod, ::File.join(__dir__, "schematic/types/metric_period")
    autoload :MetricPeriodMonthReset, ::File.join(__dir__, "schematic/types/metric_period_month_reset")
    autoload :PlanVersionStatus, ::File.join(__dir__, "schematic/types/plan_version_status")
    autoload :RuleConditionPlanVersionResponseData, ::File.join(__dir__, "schematic/types/rule_condition_plan_version_response_data")
    autoload :RuleConditionDetailResponseData, ::File.join(__dir__, "schematic/types/rule_condition_detail_response_data")
    autoload :RuleConditionGroupDetailResponseData, ::File.join(__dir__, "schematic/types/rule_condition_group_detail_response_data")
    autoload :RuleType, ::File.join(__dir__, "schematic/types/rule_type")
    autoload :RuleDetailResponseData, ::File.join(__dir__, "schematic/types/rule_detail_response_data")
    autoload :FlagInPlanResponseData, ::File.join(__dir__, "schematic/types/flag_in_plan_response_data")
    autoload :PreviewObject, ::File.join(__dir__, "schematic/types/preview_object")
    autoload :FeatureInPlanResponseData, ::File.join(__dir__, "schematic/types/feature_in_plan_response_data")
    autoload :PlanCatalogMembershipResponseData, ::File.join(__dir__, "schematic/types/plan_catalog_membership_response_data")
    autoload :PlanCurrencyPricesResponseData, ::File.join(__dir__, "schematic/types/plan_currency_prices_response_data")
    autoload :PlanIcon, ::File.join(__dir__, "schematic/types/plan_icon")
    autoload :PlanResponseData, ::File.join(__dir__, "schematic/types/plan_response_data")
    autoload :WarningTierResponseData, ::File.join(__dir__, "schematic/types/warning_tier_response_data")
    autoload :PlanEntitlementResponseData, ::File.join(__dir__, "schematic/types/plan_entitlement_response_data")
    autoload :PlanPriceCadence, ::File.join(__dir__, "schematic/types/plan_price_cadence")
    autoload :RenewalPolicy, ::File.join(__dir__, "schematic/types/renewal_policy")
    autoload :PlanVersionResponseData, ::File.join(__dir__, "schematic/types/plan_version_response_data")
    autoload :PlanGroupPlanDetailResponseData, ::File.join(__dir__, "schematic/types/plan_group_plan_detail_response_data")
    autoload :CatalogConfigurationResponseData, ::File.join(__dir__, "schematic/types/catalog_configuration_response_data")
    autoload :CatalogCreditBundleIDsResponseData, ::File.join(__dir__, "schematic/types/catalog_credit_bundle_i_ds_response_data")
    autoload :CatalogDerivedFeatureResponseData, ::File.join(__dir__, "schematic/types/catalog_derived_feature_response_data")
    autoload :CatalogDerivedFeaturesResponseData, ::File.join(__dir__, "schematic/types/catalog_derived_features_response_data")
    autoload :CatalogPlanIDsResponseData, ::File.join(__dir__, "schematic/types/catalog_plan_i_ds_response_data")
    autoload :CatalogPriceTierResponseData, ::File.join(__dir__, "schematic/types/catalog_price_tier_response_data")
    autoload :CatalogPriceResponseData, ::File.join(__dir__, "schematic/types/catalog_price_response_data")
    autoload :CatalogBundleCurrencyPriceResponseData, ::File.join(__dir__, "schematic/types/catalog_bundle_currency_price_response_data")
    autoload :CatalogCapabilitiesResponseData, ::File.join(__dir__, "schematic/types/catalog_capabilities_response_data")
    autoload :CatalogCreditBundleResponseData, ::File.join(__dir__, "schematic/types/catalog_credit_bundle_response_data")
    autoload :CatalogCreditGrantResponseData, ::File.join(__dir__, "schematic/types/catalog_credit_grant_response_data")
    autoload :CatalogCurrencyPricesResponseData, ::File.join(__dir__, "schematic/types/catalog_currency_prices_response_data")
    autoload :CatalogCustomPlanCtaResponseData, ::File.join(__dir__, "schematic/types/catalog_custom_plan_cta_response_data")
    autoload :CatalogPlanEntitlementResponseData, ::File.join(__dir__, "schematic/types/catalog_plan_entitlement_response_data")
    autoload :CatalogPlanResponseData, ::File.join(__dir__, "schematic/types/catalog_plan_response_data")
    autoload :PublicCatalogResponseData, ::File.join(__dir__, "schematic/types/public_catalog_response_data")
    autoload :CheckoutSubscription, ::File.join(__dir__, "schematic/types/checkout_subscription")
    autoload :BillingProductRecordResponseData, ::File.join(__dir__, "schematic/types/billing_product_record_response_data")
    autoload :CreditCurrencyPrice, ::File.join(__dir__, "schematic/types/credit_currency_price")
    autoload :BillingCreditView, ::File.join(__dir__, "schematic/types/billing_credit_view")
    autoload :BillingProductForSubscriptionResponseData, ::File.join(__dir__, "schematic/types/billing_product_for_subscription_response_data")
    autoload :BillingSubscriptionDiscountView, ::File.join(__dir__, "schematic/types/billing_subscription_discount_view")
    autoload :BillingSubscriptionView, ::File.join(__dir__, "schematic/types/billing_subscription_view")
    autoload :CheckoutFieldWithValue, ::File.join(__dir__, "schematic/types/checkout_field_with_value")
    autoload :CheckoutProblemCode, ::File.join(__dir__, "schematic/types/checkout_problem_code")
    autoload :CheckoutProblemSource, ::File.join(__dir__, "schematic/types/checkout_problem_source")
    autoload :CheckoutProblemResponseData, ::File.join(__dir__, "schematic/types/checkout_problem_response_data")
    autoload :CompanyEventPeriodMetricsResponseData, ::File.join(__dir__, "schematic/types/company_event_period_metrics_response_data")
    autoload :GenericPreviewObject, ::File.join(__dir__, "schematic/types/generic_preview_object")
    autoload :CompanyPlanCreditGrantView, ::File.join(__dir__, "schematic/types/company_plan_credit_grant_view")
    autoload :CompanyPlanWithBillingSubView, ::File.join(__dir__, "schematic/types/company_plan_with_billing_sub_view")
    autoload :TraitDefinitionComparableType, ::File.join(__dir__, "schematic/types/trait_definition_comparable_type")
    autoload :TraitDefinition, ::File.join(__dir__, "schematic/types/trait_definition")
    autoload :Condition, ::File.join(__dir__, "schematic/types/condition")
    autoload :ConditionGroup, ::File.join(__dir__, "schematic/types/condition_group")
    autoload :CustomPlanActivationStrategy, ::File.join(__dir__, "schematic/types/custom_plan_activation_strategy")
    autoload :CustomPlanBillingStatus, ::File.join(__dir__, "schematic/types/custom_plan_billing_status")
    autoload :PlanBillingSource, ::File.join(__dir__, "schematic/types/plan_billing_source")
    autoload :CustomPlanBillingResponseData, ::File.join(__dir__, "schematic/types/custom_plan_billing_response_data")
    autoload :EntityKeyDefinitionResponseData, ::File.join(__dir__, "schematic/types/entity_key_definition_response_data")
    autoload :EntityKeyDetailResponseData, ::File.join(__dir__, "schematic/types/entity_key_detail_response_data")
    autoload :EntityTraitDetailResponseData, ::File.join(__dir__, "schematic/types/entity_trait_detail_response_data")
    autoload :WarningTier, ::File.join(__dir__, "schematic/types/warning_tier")
    autoload :FeatureEntitlement, ::File.join(__dir__, "schematic/types/feature_entitlement")
    autoload :MigrationProrationBehavior, ::File.join(__dir__, "schematic/types/migration_proration_behavior")
    autoload :PlanVersionMigrationStrategy, ::File.join(__dir__, "schematic/types/plan_version_migration_strategy")
    autoload :PendingMigrationResponseData, ::File.join(__dir__, "schematic/types/pending_migration_response_data")
    autoload :Rule, ::File.join(__dir__, "schematic/types/rule")
    autoload :ScheduledDowngradeResponseData, ::File.join(__dir__, "schematic/types/scheduled_downgrade_response_data")
    autoload :CompanyDetailResponseData, ::File.join(__dir__, "schematic/types/company_detail_response_data")
    autoload :CompanyOverrideNoteResponseData, ::File.join(__dir__, "schematic/types/company_override_note_response_data")
    autoload :CompanyOverrideResponseData, ::File.join(__dir__, "schematic/types/company_override_response_data")
    autoload :CompanySubscriptionResponseData, ::File.join(__dir__, "schematic/types/company_subscription_response_data")
    autoload :CreditBundlePurchaseResponseData, ::File.join(__dir__, "schematic/types/credit_bundle_purchase_response_data")
    autoload :CreditGrantDetail, ::File.join(__dir__, "schematic/types/credit_grant_detail")
    autoload :CreditUsageAggregation, ::File.join(__dir__, "schematic/types/credit_usage_aggregation")
    autoload :EntitlementType, ::File.join(__dir__, "schematic/types/entitlement_type")
    autoload :FeatureUsageResponseData, ::File.join(__dir__, "schematic/types/feature_usage_response_data")
    autoload :FeatureUsageDetailResponseData, ::File.join(__dir__, "schematic/types/feature_usage_detail_response_data")
    autoload :PlanDetailResponseData, ::File.join(__dir__, "schematic/types/plan_detail_response_data")
    autoload :UsageBasedEntitlementResponseData, ::File.join(__dir__, "schematic/types/usage_based_entitlement_response_data")
    autoload :CheckoutDataResponseData, ::File.join(__dir__, "schematic/types/checkout_data_response_data")
    autoload :CheckoutChargeTiming, ::File.join(__dir__, "schematic/types/checkout_charge_timing")
    autoload :PreviewSubscriptionDiscountResponseData, ::File.join(__dir__, "schematic/types/preview_subscription_discount_response_data")
    autoload :ProrationLineKind, ::File.join(__dir__, "schematic/types/proration_line_kind")
    autoload :PreviewSubscriptionProrationLineResponseData, ::File.join(__dir__, "schematic/types/preview_subscription_proration_line_response_data")
    autoload :PreviewSubscriptionProrationResponseData, ::File.join(__dir__, "schematic/types/preview_subscription_proration_response_data")
    autoload :PreviewSubscriptionUpcomingInvoiceLineItems, ::File.join(__dir__, "schematic/types/preview_subscription_upcoming_invoice_line_items")
    autoload :PreviewSubscriptionFinanceResponseData, ::File.join(__dir__, "schematic/types/preview_subscription_finance_response_data")
    autoload :PreviewSubscriptionChangeResponseData, ::File.join(__dir__, "schematic/types/preview_subscription_change_response_data")
    autoload :CompanyBillingAddressView, ::File.join(__dir__, "schematic/types/company_billing_address_view")
    autoload :CompanyBillingCheckoutSettings, ::File.join(__dir__, "schematic/types/company_billing_checkout_settings")
    autoload :CompanyTaxIdView, ::File.join(__dir__, "schematic/types/company_tax_id_view")
    autoload :CompanyBillingDetailsResponseData, ::File.join(__dir__, "schematic/types/company_billing_details_response_data")
    autoload :ManagePlanResponseResponseData, ::File.join(__dir__, "schematic/types/manage_plan_response_response_data")
    autoload :ManagePlanPreviewResponseResponseData, ::File.join(__dir__, "schematic/types/manage_plan_preview_response_response_data")
    autoload :SubscriptionType, ::File.join(__dir__, "schematic/types/subscription_type")
    autoload :InferenceCostAmountResponseData, ::File.join(__dir__, "schematic/types/inference_cost_amount_response_data")
    autoload :InferenceModelCostResponseData, ::File.join(__dir__, "schematic/types/inference_model_cost_response_data")
    autoload :CompanyInferenceCostResponseData, ::File.join(__dir__, "schematic/types/company_inference_cost_response_data")
    autoload :CompanyResponseData, ::File.join(__dir__, "schematic/types/company_response_data")
    autoload :CompanyBillingEntityResponseData, ::File.join(__dir__, "schematic/types/company_billing_entity_response_data")
    autoload :CompanyBillingEntitySubscriptionResponseData, ::File.join(__dir__, "schematic/types/company_billing_entity_subscription_response_data")
    autoload :CompanyMembershipDetailResponseData, ::File.join(__dir__, "schematic/types/company_membership_detail_response_data")
    autoload :EntityTraitDefinitionUsage, ::File.join(__dir__, "schematic/types/entity_trait_definition_usage")
    autoload :EntityTraitValue, ::File.join(__dir__, "schematic/types/entity_trait_value")
    autoload :PlanChangeAction, ::File.join(__dir__, "schematic/types/plan_change_action")
    autoload :PlanChangeBasePlanAction, ::File.join(__dir__, "schematic/types/plan_change_base_plan_action")
    autoload :IntegrationResponseData, ::File.join(__dir__, "schematic/types/integration_response_data")
    autoload :PlanChangeAmendmentStatus, ::File.join(__dir__, "schematic/types/plan_change_amendment_status")
    autoload :PlanChangeSubscriptionAction, ::File.join(__dir__, "schematic/types/plan_change_subscription_action")
    autoload :PlanSnapshotView, ::File.join(__dir__, "schematic/types/plan_snapshot_view")
    autoload :PlanVersionSnapshotView, ::File.join(__dir__, "schematic/types/plan_version_snapshot_view")
    autoload :SubscriptionTraitUpdate, ::File.join(__dir__, "schematic/types/subscription_trait_update")
    autoload :TrialStatus, ::File.join(__dir__, "schematic/types/trial_status")
    autoload :PlanChangeResponseData, ::File.join(__dir__, "schematic/types/plan_change_response_data")
    autoload :PlanTraitResponseData, ::File.join(__dir__, "schematic/types/plan_trait_response_data")
    autoload :UserDetailResponseData, ::File.join(__dir__, "schematic/types/user_detail_response_data")
    autoload :UserResponseData, ::File.join(__dir__, "schematic/types/user_response_data")
    autoload :CreditUsage, ::File.join(__dir__, "schematic/types/credit_usage")
    autoload :FeatureCompanyResponseData, ::File.join(__dir__, "schematic/types/feature_company_response_data")
    autoload :TimeSeriesGranularity, ::File.join(__dir__, "schematic/types/time_series_granularity")
    autoload :FeatureUsageHistoryResponseData, ::File.join(__dir__, "schematic/types/feature_usage_history_response_data")
    autoload :LimitTimeSeriesPointResponseData, ::File.join(__dir__, "schematic/types/limit_time_series_point_response_data")
    autoload :UsageTimeSeriesPointResponseData, ::File.join(__dir__, "schematic/types/usage_time_series_point_response_data")
    autoload :FeatureUsageTimeSeriesResponseData, ::File.join(__dir__, "schematic/types/feature_usage_time_series_response_data")
    autoload :FlagDetailResponseData, ::File.join(__dir__, "schematic/types/flag_detail_response_data")
    autoload :FeatureDetailResponseData, ::File.join(__dir__, "schematic/types/feature_detail_response_data")
    autoload :FeatureCompanyUserResponseData, ::File.join(__dir__, "schematic/types/feature_company_user_response_data")
    autoload :PlanIssueResponseData, ::File.join(__dir__, "schematic/types/plan_issue_response_data")
    autoload :SkippedEntitlementErrorResponseData, ::File.join(__dir__, "schematic/types/skipped_entitlement_error_response_data")
    autoload :SkippedEntitlementResponseData, ::File.join(__dir__, "schematic/types/skipped_entitlement_response_data")
    autoload :DuplicatePlanEntitlementsResponseResponseData, ::File.join(__dir__, "schematic/types/duplicate_plan_entitlements_response_response_data")
    autoload :UserCreditUsageResponseData, ::File.join(__dir__, "schematic/types/user_credit_usage_response_data")
    autoload :UserFeatureUsageResponseData, ::File.join(__dir__, "schematic/types/user_feature_usage_response_data")
    autoload :UserUsageByCompanyResponseData, ::File.join(__dir__, "schematic/types/user_usage_by_company_response_data")
    autoload :CompanyUserUsageMetricsResponseData, ::File.join(__dir__, "schematic/types/company_user_usage_metrics_response_data")
    autoload :UserUsageMetric, ::File.join(__dir__, "schematic/types/user_usage_metric")
    autoload :CompanyUserUsageRowResponseData, ::File.join(__dir__, "schematic/types/company_user_usage_row_response_data")
    autoload :CompanyUserUsageResponseData, ::File.join(__dir__, "schematic/types/company_user_usage_response_data")
    autoload :UserDailyCreditPointResponseData, ::File.join(__dir__, "schematic/types/user_daily_credit_point_response_data")
    autoload :UserDailyUsagePointResponseData, ::File.join(__dir__, "schematic/types/user_daily_usage_point_response_data")
    autoload :UserUsageDetailResponseData, ::File.join(__dir__, "schematic/types/user_usage_detail_response_data")
    autoload :BillingProductPlanResponseData, ::File.join(__dir__, "schematic/types/billing_product_plan_response_data")
    autoload :PlanVersionBillingProductChangeResponseData, ::File.join(__dir__, "schematic/types/plan_version_billing_product_change_response_data")
    autoload :PlanVersionDiffChangeType, ::File.join(__dir__, "schematic/types/plan_version_diff_change_type")
    autoload :PlanVersionCreditGrantChangeResponseData, ::File.join(__dir__, "schematic/types/plan_version_credit_grant_change_response_data")
    autoload :PlanVersionDiffPriceCadence, ::File.join(__dir__, "schematic/types/plan_version_diff_price_cadence")
    autoload :PlanVersionEntitlementChangeResponseData, ::File.join(__dir__, "schematic/types/plan_version_entitlement_change_response_data")
    autoload :PlanVersionFieldChangeResponseData, ::File.join(__dir__, "schematic/types/plan_version_field_change_response_data")
    autoload :PlanVersionPriceChangeResponseData, ::File.join(__dir__, "schematic/types/plan_version_price_change_response_data")
    autoload :PlanVersionDiffResponseData, ::File.join(__dir__, "schematic/types/plan_version_diff_response_data")
    autoload :AmendmentProrationLandsOn, ::File.join(__dir__, "schematic/types/amendment_proration_lands_on")
    autoload :PublishPreviewPayInAdvanceResponseData, ::File.join(__dir__, "schematic/types/publish_preview_pay_in_advance_response_data")
    autoload :PublishPreviewPaymentMethodResponseData, ::File.join(__dir__, "schematic/types/publish_preview_payment_method_response_data")
    autoload :PublishPreviewProrationLineResponseData, ::File.join(__dir__, "schematic/types/publish_preview_proration_line_response_data")
    autoload :PublishPreviewResponseData, ::File.join(__dir__, "schematic/types/publish_preview_response_data")
    autoload :ComponentEntityType, ::File.join(__dir__, "schematic/types/component_entity_type")
    autoload :ComponentState, ::File.join(__dir__, "schematic/types/component_state")
    autoload :ComponentResponseData, ::File.join(__dir__, "schematic/types/component_response_data")
    autoload :BillingProductPriceResponseData, ::File.join(__dir__, "schematic/types/billing_product_price_response_data")
    autoload :CreditBundleCurrencyPrice, ::File.join(__dir__, "schematic/types/credit_bundle_currency_price")
    autoload :BillingCreditBundleView, ::File.join(__dir__, "schematic/types/billing_credit_bundle_view")
    autoload :CheckoutBundlePurchaseBehavior, ::File.join(__dir__, "schematic/types/checkout_bundle_purchase_behavior")
    autoload :CompanyPlanInvalidReason, ::File.join(__dir__, "schematic/types/company_plan_invalid_reason")
    autoload :CustomPlanConfig, ::File.join(__dir__, "schematic/types/custom_plan_config")
    autoload :EstimatedPlanTotal, ::File.join(__dir__, "schematic/types/estimated_plan_total")
    autoload :PlanCreditGrantView, ::File.join(__dir__, "schematic/types/plan_credit_grant_view")
    autoload :PlanCreditVisibility, ::File.join(__dir__, "schematic/types/plan_credit_visibility")
    autoload :CompanyPlanDetailResponseData, ::File.join(__dir__, "schematic/types/company_plan_detail_response_data")
    autoload :CompatiblePlans, ::File.join(__dir__, "schematic/types/compatible_plans")
    autoload :ComponentCapabilities, ::File.join(__dir__, "schematic/types/component_capabilities")
    autoload :ComponentCheckoutSettings, ::File.join(__dir__, "schematic/types/component_checkout_settings")
    autoload :ComponentDisplaySettings, ::File.join(__dir__, "schematic/types/component_display_settings")
    autoload :CreditTransferView, ::File.join(__dir__, "schematic/types/credit_transfer_view")
    autoload :CreditCompanyGrantView, ::File.join(__dir__, "schematic/types/credit_company_grant_view")
    autoload :StripeEmbedInfo, ::File.join(__dir__, "schematic/types/stripe_embed_info")
    autoload :UpcomingInvoiceResponseData, ::File.join(__dir__, "schematic/types/upcoming_invoice_response_data")
    autoload :ComponentPreviewResponseData, ::File.join(__dir__, "schematic/types/component_preview_response_data")
    autoload :PlanBundleResponseData, ::File.join(__dir__, "schematic/types/plan_bundle_response_data")
    autoload :DataExportStatus, ::File.join(__dir__, "schematic/types/data_export_status")
    autoload :DataExportType, ::File.join(__dir__, "schematic/types/data_export_type")
    autoload :AuditLogExportMetadata, ::File.join(__dir__, "schematic/types/audit_log_export_metadata")
    autoload :CompanyFeatureUsageExportMetadataSortOrderDirection, ::File.join(__dir__, "schematic/types/company_feature_usage_export_metadata_sort_order_direction")
    autoload :CompanyFeatureUsageExportMetadataVisibleColumnsItem, ::File.join(__dir__, "schematic/types/company_feature_usage_export_metadata_visible_columns_item")
    autoload :CompanyFeatureUsageExportMetadata, ::File.join(__dir__, "schematic/types/company_feature_usage_export_metadata")
    autoload :EventExportMetadataEventTypesItem, ::File.join(__dir__, "schematic/types/event_export_metadata_event_types_item")
    autoload :EventExportMetadata, ::File.join(__dir__, "schematic/types/event_export_metadata")
    autoload :DataExportMetadata, ::File.join(__dir__, "schematic/types/data_export_metadata")
    autoload :DataExportOutputFileType, ::File.join(__dir__, "schematic/types/data_export_output_file_type")
    autoload :DataExportResponseData, ::File.join(__dir__, "schematic/types/data_export_response_data")
    autoload :RawEventResponseData, ::File.join(__dir__, "schematic/types/raw_event_response_data")
    autoload :RawEventBatchResponseData, ::File.join(__dir__, "schematic/types/raw_event_batch_response_data")
    autoload :EventType, ::File.join(__dir__, "schematic/types/event_type")
    autoload :EventStatus, ::File.join(__dir__, "schematic/types/event_status")
    autoload :InferenceCostSource, ::File.join(__dir__, "schematic/types/inference_cost_source")
    autoload :EventDetailResponseData, ::File.join(__dir__, "schematic/types/event_detail_response_data")
    autoload :OtlpEnvironmentSettingsResponseData, ::File.join(__dir__, "schematic/types/otlp_environment_settings_response_data")
    autoload :SegmentStatusResp, ::File.join(__dir__, "schematic/types/segment_status_resp")
    autoload :FlagResponseData, ::File.join(__dir__, "schematic/types/flag_response_data")
    autoload :RulesDetailResponseData, ::File.join(__dir__, "schematic/types/rules_detail_response_data")
    autoload :CheckFlagResponseData, ::File.join(__dir__, "schematic/types/check_flag_response_data")
    autoload :FlagCheckReservationResponseData, ::File.join(__dir__, "schematic/types/flag_check_reservation_response_data")
    autoload :CheckAndReserveFlagResponseData, ::File.join(__dir__, "schematic/types/check_and_reserve_flag_response_data")
    autoload :CompanyCreditBalance, ::File.join(__dir__, "schematic/types/company_credit_balance")
    autoload :CreditSpendWindow, ::File.join(__dir__, "schematic/types/credit_spend_window")
    autoload :CreditSpendPolicy, ::File.join(__dir__, "schematic/types/credit_spend_policy")
    autoload :DatastreamCompanyPlan, ::File.join(__dir__, "schematic/types/datastream_company_plan")
    autoload :CheckFlagsResponseData, ::File.join(__dir__, "schematic/types/check_flags_response_data")
    autoload :CheckFlagsBulkResponseData, ::File.join(__dir__, "schematic/types/check_flags_bulk_response_data")
    autoload :ActivityEntryResponseData, ::File.join(__dir__, "schematic/types/activity_entry_response_data")
    autoload :ActivityResponseResponseData, ::File.join(__dir__, "schematic/types/activity_response_response_data")
    autoload :EnvironmentUsagePointResponseData, ::File.join(__dir__, "schematic/types/environment_usage_point_response_data")
    autoload :EnvironmentFeatureUsageTimeSeriesResponseData, ::File.join(__dir__, "schematic/types/environment_feature_usage_time_series_response_data")
    autoload :PlanGrowthPointResponseData, ::File.join(__dir__, "schematic/types/plan_growth_point_response_data")
    autoload :PlanGrowthResponseData, ::File.join(__dir__, "schematic/types/plan_growth_response_data")
    autoload :MrrResponseData, ::File.join(__dir__, "schematic/types/mrr_response_data")
    autoload :InsightsSummaryResponseData, ::File.join(__dir__, "schematic/types/insights_summary_response_data")
    autoload :TopFeatureByUsageResponseData, ::File.join(__dir__, "schematic/types/top_feature_by_usage_response_data")
    autoload :TopFeaturesByUsageResponseData, ::File.join(__dir__, "schematic/types/top_features_by_usage_response_data")
    autoload :EnvironmentTraitUsageTimeSeriesResponseData, ::File.join(__dir__, "schematic/types/environment_trait_usage_time_series_response_data")
    autoload :IntegrationsResponseData, ::File.join(__dir__, "schematic/types/integrations_response_data")
    autoload :ClerkIntegrationConfig, ::File.join(__dir__, "schematic/types/clerk_integration_config")
    autoload :IntegrationCapabilities, ::File.join(__dir__, "schematic/types/integration_capabilities")
    autoload :MetronomeIntegrationConfig, ::File.join(__dir__, "schematic/types/metronome_integration_config")
    autoload :OrbIntegrationConfig, ::File.join(__dir__, "schematic/types/orb_integration_config")
    autoload :StripeIntegrationConfig, ::File.join(__dir__, "schematic/types/stripe_integration_config")
    autoload :WorkOsIntegrationConfig, ::File.join(__dir__, "schematic/types/work_os_integration_config")
    autoload :IntegrationConfig, ::File.join(__dir__, "schematic/types/integration_config")
    autoload :IntegrationsListResponseData, ::File.join(__dir__, "schematic/types/integrations_list_response_data")
    autoload :IntegrationWebhookUrlResponseData, ::File.join(__dir__, "schematic/types/integration_webhook_url_response_data")
    autoload :CompanyMatchingCriteria, ::File.join(__dir__, "schematic/types/company_matching_criteria")
    autoload :IntegrationInstallConfig, ::File.join(__dir__, "schematic/types/integration_install_config")
    autoload :IntegrationInstallResponseData, ::File.join(__dir__, "schematic/types/integration_install_response_data")
    autoload :IntegrationsDataSetResponseData, ::File.join(__dir__, "schematic/types/integrations_data_set_response_data")
    autoload :StripeSandboxClaimLink, ::File.join(__dir__, "schematic/types/stripe_sandbox_claim_link")
    autoload :ClaimedStripeSandboxKeysResponseData, ::File.join(__dir__, "schematic/types/claimed_stripe_sandbox_keys_response_data")
    autoload :StripeSandboxKeysResponseData, ::File.join(__dir__, "schematic/types/stripe_sandbox_keys_response_data")
    autoload :StripeSandboxInstallResponseData, ::File.join(__dir__, "schematic/types/stripe_sandbox_install_response_data")
    autoload :StripeSandboxCountriesResponseData, ::File.join(__dir__, "schematic/types/stripe_sandbox_countries_response_data")
    autoload :LicenseResponseData, ::File.join(__dir__, "schematic/types/license_response_data")
    autoload :CheckoutFieldResponseData, ::File.join(__dir__, "schematic/types/checkout_field_response_data")
    autoload :CheckoutSettingsResponseData, ::File.join(__dir__, "schematic/types/checkout_settings_response_data")
    autoload :ComponentSettingsResponseData, ::File.join(__dir__, "schematic/types/component_settings_response_data")
    autoload :PlanCreditOrder, ::File.join(__dir__, "schematic/types/plan_credit_order")
    autoload :PlanEntitlementsOrder, ::File.join(__dir__, "schematic/types/plan_entitlements_order")
    autoload :PlanGroupBundleOrder, ::File.join(__dir__, "schematic/types/plan_group_bundle_order")
    autoload :PlanGroupPlanEntitlementsOrder, ::File.join(__dir__, "schematic/types/plan_group_plan_entitlements_order")
    autoload :PlanGroupDetailResponseData, ::File.join(__dir__, "schematic/types/plan_group_detail_response_data")
    autoload :CompatiblePlansResponseData, ::File.join(__dir__, "schematic/types/compatible_plans_response_data")
    autoload :CreditsInPlan, ::File.join(__dir__, "schematic/types/credits_in_plan")
    autoload :EntitlementsInPlan, ::File.join(__dir__, "schematic/types/entitlements_in_plan")
    autoload :OrderedPlansInGroup, ::File.join(__dir__, "schematic/types/ordered_plans_in_group")
    autoload :PlanGroupResponseData, ::File.join(__dir__, "schematic/types/plan_group_response_data")
    autoload :PlanVersionCompanyMigrationStatus, ::File.join(__dir__, "schematic/types/plan_version_company_migration_status")
    autoload :MigrationErrorCode, ::File.join(__dir__, "schematic/types/migration_error_code")
    autoload :PlanVersionCompanyMigrationResponseData, ::File.join(__dir__, "schematic/types/plan_version_company_migration_response_data")
    autoload :PlanVersionMigrationStatus, ::File.join(__dir__, "schematic/types/plan_version_migration_status")
    autoload :PlanVersionMigrationResponseData, ::File.join(__dir__, "schematic/types/plan_version_migration_response_data")
    autoload :PlanVersionMigrationPreviewNoteResponseData, ::File.join(__dir__, "schematic/types/plan_version_migration_preview_note_response_data")
    autoload :PlanVersionMigrationPreviewCompanyResponseData, ::File.join(__dir__, "schematic/types/plan_version_migration_preview_company_response_data")
    autoload :PlanVersionMigrationPreviewResponseData, ::File.join(__dir__, "schematic/types/plan_version_migration_preview_response_data")
    autoload :PlanViewPublicResponseData, ::File.join(__dir__, "schematic/types/plan_view_public_response_data")
    autoload :PublicPlansResponseData, ::File.join(__dir__, "schematic/types/public_plans_response_data")
    autoload :ScheduledCheckoutStatus, ::File.join(__dir__, "schematic/types/scheduled_checkout_status")
    autoload :ScheduledCheckoutResponseData, ::File.join(__dir__, "schematic/types/scheduled_checkout_response_data")
    autoload :TemporaryAccessTokenIssuerType, ::File.join(__dir__, "schematic/types/temporary_access_token_issuer_type")
    autoload :TemporaryAccessTokenResourceType, ::File.join(__dir__, "schematic/types/temporary_access_token_resource_type")
    autoload :IssueTemporaryAccessTokenResponseData, ::File.join(__dir__, "schematic/types/issue_temporary_access_token_response_data")
    autoload :CreditTriggerConfig, ::File.join(__dir__, "schematic/types/credit_trigger_config")
    autoload :EntitlementTriggerConfig, ::File.join(__dir__, "schematic/types/entitlement_trigger_config")
    autoload :WebhookEventStatus, ::File.join(__dir__, "schematic/types/webhook_event_status")
    autoload :WebhookRequestType, ::File.join(__dir__, "schematic/types/webhook_request_type")
    autoload :WebhookStatus, ::File.join(__dir__, "schematic/types/webhook_status")
    autoload :WebhookResponseData, ::File.join(__dir__, "schematic/types/webhook_response_data")
    autoload :WebhookEventDetailResponseData, ::File.join(__dir__, "schematic/types/webhook_event_detail_response_data")
    autoload :TestWebhookResponseData, ::File.join(__dir__, "schematic/types/test_webhook_response_data")
    autoload :ApiError, ::File.join(__dir__, "schematic/types/api_error")
    autoload :BillingInvoiceWebhook, ::File.join(__dir__, "schematic/types/billing_invoice_webhook")
    autoload :BillingProductPricing, ::File.join(__dir__, "schematic/types/billing_product_pricing")
    autoload :BillingSubscriptionDiscount, ::File.join(__dir__, "schematic/types/billing_subscription_discount")
    autoload :BillingSubscriptionPeriodLineWebhook, ::File.join(__dir__, "schematic/types/billing_subscription_period_line_webhook")
    autoload :BillingSubscriptionPeriodWebhook, ::File.join(__dir__, "schematic/types/billing_subscription_period_webhook")
    autoload :CaptureRawEvent, ::File.join(__dir__, "schematic/types/capture_raw_event")
    autoload :CaptureRawEventBatch, ::File.join(__dir__, "schematic/types/capture_raw_event_batch")
    autoload :CatalogConfigOrderedBundle, ::File.join(__dir__, "schematic/types/catalog_config_ordered_bundle")
    autoload :CatalogConfigOrderedEntitlement, ::File.join(__dir__, "schematic/types/catalog_config_ordered_entitlement")
    autoload :CatalogConfigPlanCredit, ::File.join(__dir__, "schematic/types/catalog_config_plan_credit")
    autoload :CatalogConfigOrderedPlan, ::File.join(__dir__, "schematic/types/catalog_config_ordered_plan")
    autoload :CatalogDetailResponseData, ::File.join(__dir__, "schematic/types/catalog_detail_response_data")
    autoload :CatalogEntitlementResponseData, ::File.join(__dir__, "schematic/types/catalog_entitlement_response_data")
    autoload :CheckoutFieldValue, ::File.join(__dir__, "schematic/types/checkout_field_value")
    autoload :UpdateAddOnRequestBody, ::File.join(__dir__, "schematic/types/update_add_on_request_body")
    autoload :UpdateAutoTopupOverrideRequestBody, ::File.join(__dir__, "schematic/types/update_auto_topup_override_request_body")
    autoload :UpdateCreditBundleRequestBody, ::File.join(__dir__, "schematic/types/update_credit_bundle_request_body")
    autoload :UpdatePayInAdvanceRequestBody, ::File.join(__dir__, "schematic/types/update_pay_in_advance_request_body")
    autoload :ChangeSubscriptionInternalRequestBody, ::File.join(__dir__, "schematic/types/change_subscription_internal_request_body")
    autoload :ChangeSubscriptionRequestBody, ::File.join(__dir__, "schematic/types/change_subscription_request_body")
    autoload :PreflightEventQuantitiesRequestBody, ::File.join(__dir__, "schematic/types/preflight_event_quantities_request_body")
    autoload :PreflightEventUsageRequestBody, ::File.join(__dir__, "schematic/types/preflight_event_usage_request_body")
    autoload :PreflightRequestBody, ::File.join(__dir__, "schematic/types/preflight_request_body")
    autoload :CheckFlagRequestBody, ::File.join(__dir__, "schematic/types/check_flag_request_body")
    autoload :CheckoutFieldInput, ::File.join(__dir__, "schematic/types/checkout_field_input")
    autoload :CompanyBillingDetailsView, ::File.join(__dir__, "schematic/types/company_billing_details_view")
    autoload :CompanyMembershipResponseData, ::File.join(__dir__, "schematic/types/company_membership_response_data")
    autoload :ComponentHydrateResponseData, ::File.join(__dir__, "schematic/types/component_hydrate_response_data")
    autoload :ConditionGroupResponseData, ::File.join(__dir__, "schematic/types/condition_group_response_data")
    autoload :ConditionView, ::File.join(__dir__, "schematic/types/condition_view")
    autoload :ConditionGroupView, ::File.join(__dir__, "schematic/types/condition_group_view")
    autoload :ConditionResponseData, ::File.join(__dir__, "schematic/types/condition_response_data")
    autoload :CouponRequestBody, ::File.join(__dir__, "schematic/types/coupon_request_body")
    autoload :CreditAutoTopupAmountType, ::File.join(__dir__, "schematic/types/credit_auto_topup_amount_type")
    autoload :CreditGrantPriceTierRequestBody, ::File.join(__dir__, "schematic/types/credit_grant_price_tier_request_body")
    autoload :PlanCreditGrantWarningTierRequestBody, ::File.join(__dir__, "schematic/types/plan_credit_grant_warning_tier_request_body")
    autoload :CreateBillingPlanCreditGrantRequestBody, ::File.join(__dir__, "schematic/types/create_billing_plan_credit_grant_request_body")
    autoload :CreateBillingPriceTierRequestBody, ::File.join(__dir__, "schematic/types/create_billing_price_tier_request_body")
    autoload :CreateCustomPlanBundlePlanRequestBody, ::File.join(__dir__, "schematic/types/create_custom_plan_bundle_plan_request_body")
    autoload :CreatePriceTierRequestBody, ::File.join(__dir__, "schematic/types/create_price_tier_request_body")
    autoload :CurrencyPriceRequestBody, ::File.join(__dir__, "schematic/types/currency_price_request_body")
    autoload :WarningTierRequestBody, ::File.join(__dir__, "schematic/types/warning_tier_request_body")
    autoload :CreateEntitlementInBundleRequestBody, ::File.join(__dir__, "schematic/types/create_entitlement_in_bundle_request_body")
    autoload :CreateEntitlementReqCommon, ::File.join(__dir__, "schematic/types/create_entitlement_req_common")
    autoload :EventBodyFlagCheck, ::File.join(__dir__, "schematic/types/event_body_flag_check")
    autoload :EventBodyIdentifyCompany, ::File.join(__dir__, "schematic/types/event_body_identify_company")
    autoload :EventBodyIdentify, ::File.join(__dir__, "schematic/types/event_body_identify")
    autoload :EventBodyInference, ::File.join(__dir__, "schematic/types/event_body_inference")
    autoload :EventBodyTrack, ::File.join(__dir__, "schematic/types/event_body_track")
    autoload :EventBody, ::File.join(__dir__, "schematic/types/event_body")
    autoload :CreateEventRequestBody, ::File.join(__dir__, "schematic/types/create_event_request_body")
    autoload :CreateFlagRequestBody, ::File.join(__dir__, "schematic/types/create_flag_request_body")
    autoload :CreateOrUpdateConditionRequestBody, ::File.join(__dir__, "schematic/types/create_or_update_condition_request_body")
    autoload :CreateOrUpdateConditionGroupRequestBody, ::File.join(__dir__, "schematic/types/create_or_update_condition_group_request_body")
    autoload :CreateOrUpdateFlagRequestBody, ::File.join(__dir__, "schematic/types/create_or_update_flag_request_body")
    autoload :CreateOrUpdateRuleRequestBody, ::File.join(__dir__, "schematic/types/create_or_update_rule_request_body")
    autoload :CreatePlanRequestBody, ::File.join(__dir__, "schematic/types/create_plan_request_body")
    autoload :CreditBundleCurrencyPriceRequestBody, ::File.join(__dir__, "schematic/types/credit_bundle_currency_price_request_body")
    autoload :CreditCurrencyPriceRequestBody, ::File.join(__dir__, "schematic/types/credit_currency_price_request_body")
    autoload :CreditGrantExpiryRequestBody, ::File.join(__dir__, "schematic/types/credit_grant_expiry_request_body")
    autoload :CreditsAutoTopupCompanySummary, ::File.join(__dir__, "schematic/types/credits_auto_topup_company_summary")
    autoload :CreditsAutoTopupCreditSummary, ::File.join(__dir__, "schematic/types/credits_auto_topup_credit_summary")
    autoload :CreditsAutoTopupHardFailure, ::File.join(__dir__, "schematic/types/credits_auto_topup_hard_failure")
    autoload :CreditsAutoTopupRetryFailure, ::File.join(__dir__, "schematic/types/credits_auto_topup_retry_failure")
    autoload :CreditsAutoTopupSuccess, ::File.join(__dir__, "schematic/types/credits_auto_topup_success")
    autoload :CreditsWebhookCompanySummary, ::File.join(__dir__, "schematic/types/credits_webhook_company_summary")
    autoload :CreditsWebhookCreditSummary, ::File.join(__dir__, "schematic/types/credits_webhook_credit_summary")
    autoload :CreditsCreditPurchaseSuccess, ::File.join(__dir__, "schematic/types/credits_credit_purchase_success")
    autoload :CustomerBillingAddress, ::File.join(__dir__, "schematic/types/customer_billing_address")
    autoload :DataEventPayload, ::File.join(__dir__, "schematic/types/data_event_payload")
    autoload :DeleteBillingPlanCreditGrantRequestBody, ::File.join(__dir__, "schematic/types/delete_billing_plan_credit_grant_request_body")
    autoload :EntityKeyResponseData, ::File.join(__dir__, "schematic/types/entity_key_response_data")
    autoload :EntityTraitResponseData, ::File.join(__dir__, "schematic/types/entity_trait_response_data")
    autoload :EventResponseData, ::File.join(__dir__, "schematic/types/event_response_data")
    autoload :RuleView, ::File.join(__dir__, "schematic/types/rule_view")
    autoload :FlagView, ::File.join(__dir__, "schematic/types/flag_view")
    autoload :FeatureView, ::File.join(__dir__, "schematic/types/feature_view")
    autoload :FeatureUsageLegacyResponseData, ::File.join(__dir__, "schematic/types/feature_usage_legacy_response_data")
    autoload :InstallIntegrationRequestBody, ::File.join(__dir__, "schematic/types/install_integration_request_body")
    autoload :InvoiceRequestBody, ::File.join(__dir__, "schematic/types/invoice_request_body")
    autoload :KeysRequestBody, ::File.join(__dir__, "schematic/types/keys_request_body")
    autoload :PlanSelection, ::File.join(__dir__, "schematic/types/plan_selection")
    autoload :ManagePlanRequest, ::File.join(__dir__, "schematic/types/manage_plan_request")
    autoload :MarkCustomPlanBillingPaidRequestBody, ::File.join(__dir__, "schematic/types/mark_custom_plan_billing_paid_request_body")
    autoload :MeterRequestBody, ::File.join(__dir__, "schematic/types/meter_request_body")
    autoload :PaymentMethodBillingDetailsRequestBody, ::File.join(__dir__, "schematic/types/payment_method_billing_details_request_body")
    autoload :PaymentMethodRequestBody, ::File.join(__dir__, "schematic/types/payment_method_request_body")
    autoload :PlanBundleAction, ::File.join(__dir__, "schematic/types/plan_bundle_action")
    autoload :UpdateBillingPlanCreditGrantRequestBody, ::File.join(__dir__, "schematic/types/update_billing_plan_credit_grant_request_body")
    autoload :PlanBundleCreditGrantRequestBody, ::File.join(__dir__, "schematic/types/plan_bundle_credit_grant_request_body")
    autoload :PlanBundleEntitlementRequestBody, ::File.join(__dir__, "schematic/types/plan_bundle_entitlement_request_body")
    autoload :PlanCurrencyPriceRequestBody, ::File.join(__dir__, "schematic/types/plan_currency_price_request_body")
    autoload :TaxIdInput, ::File.join(__dir__, "schematic/types/tax_id_input")
    autoload :PublishPlanVersionRequestBody, ::File.join(__dir__, "schematic/types/publish_plan_version_request_body")
    autoload :RuleConditionGroupResponseData, ::File.join(__dir__, "schematic/types/rule_condition_group_response_data")
    autoload :RuleConditionResponseData, ::File.join(__dir__, "schematic/types/rule_condition_response_data")
    autoload :RuleResponseData, ::File.join(__dir__, "schematic/types/rule_response_data")
    autoload :RulesEngineSchemaVersion, ::File.join(__dir__, "schematic/types/rules_engine_schema_version")
    autoload :RulesengineEntitlementValueType, ::File.join(__dir__, "schematic/types/rulesengine_entitlement_value_type")
    autoload :RulesengineMetricPeriod, ::File.join(__dir__, "schematic/types/rulesengine_metric_period")
    autoload :RulesengineMetricPeriodMonthReset, ::File.join(__dir__, "schematic/types/rulesengine_metric_period_month_reset")
    autoload :RulesengineWarningTier, ::File.join(__dir__, "schematic/types/rulesengine_warning_tier")
    autoload :RulesengineFeatureEntitlement, ::File.join(__dir__, "schematic/types/rulesengine_feature_entitlement")
    autoload :RulesengineRuleType, ::File.join(__dir__, "schematic/types/rulesengine_rule_type")
    autoload :RulesengineCheckFlagResult, ::File.join(__dir__, "schematic/types/rulesengine_check_flag_result")
    autoload :RulesengineCompanyMetric, ::File.join(__dir__, "schematic/types/rulesengine_company_metric")
    autoload :RulesengineComparableOperator, ::File.join(__dir__, "schematic/types/rulesengine_comparable_operator")
    autoload :RulesengineConditionType, ::File.join(__dir__, "schematic/types/rulesengine_condition_type")
    autoload :RulesengineEntityType, ::File.join(__dir__, "schematic/types/rulesengine_entity_type")
    autoload :RulesengineTraitDefinitionComparableType, ::File.join(__dir__, "schematic/types/rulesengine_trait_definition_comparable_type")
    autoload :RulesengineTraitDefinition, ::File.join(__dir__, "schematic/types/rulesengine_trait_definition")
    autoload :RulesengineCondition, ::File.join(__dir__, "schematic/types/rulesengine_condition")
    autoload :RulesengineConditionGroup, ::File.join(__dir__, "schematic/types/rulesengine_condition_group")
    autoload :RulesengineCreditPostpaidConfig, ::File.join(__dir__, "schematic/types/rulesengine_credit_postpaid_config")
    autoload :RulesengineCreditSpendPolicyScope, ::File.join(__dir__, "schematic/types/rulesengine_credit_spend_policy_scope")
    autoload :RulesengineCreditSpendWindow, ::File.join(__dir__, "schematic/types/rulesengine_credit_spend_window")
    autoload :RulesengineCreditSpendPolicy, ::File.join(__dir__, "schematic/types/rulesengine_credit_spend_policy")
    autoload :RulesengineRule, ::File.join(__dir__, "schematic/types/rulesengine_rule")
    autoload :RulesengineSubscription, ::File.join(__dir__, "schematic/types/rulesengine_subscription")
    autoload :RulesengineTrait, ::File.join(__dir__, "schematic/types/rulesengine_trait")
    autoload :RulesengineCompany, ::File.join(__dir__, "schematic/types/rulesengine_company")
    autoload :RulesengineFlag, ::File.join(__dir__, "schematic/types/rulesengine_flag")
    autoload :RulesengineUser, ::File.join(__dir__, "schematic/types/rulesengine_user")
    autoload :ScheduledDowngradeConfigBehavior, ::File.join(__dir__, "schematic/types/scheduled_downgrade_config_behavior")
    autoload :TemporaryAccessTokenResponseData, ::File.join(__dir__, "schematic/types/temporary_access_token_response_data")
    autoload :UpdateEntitlementReqCommon, ::File.join(__dir__, "schematic/types/update_entitlement_req_common")
    autoload :UpdatePlanRequestBody, ::File.join(__dir__, "schematic/types/update_plan_request_body")
    autoload :UpdatePlanTraitTraitRequestBody, ::File.join(__dir__, "schematic/types/update_plan_trait_trait_request_body")
    autoload :UpdateRuleRequestBody, ::File.join(__dir__, "schematic/types/update_rule_request_body")
    autoload :UpsertBillingProductRequestBody, ::File.join(__dir__, "schematic/types/upsert_billing_product_request_body")
    autoload :UpsertCompanyRequestBody, ::File.join(__dir__, "schematic/types/upsert_company_request_body")
    autoload :UpsertTraitRequestBody, ::File.join(__dir__, "schematic/types/upsert_trait_request_body")
    autoload :UpsertUserRequestBody, ::File.join(__dir__, "schematic/types/upsert_user_request_body")
    autoload :UpsertUserSubRequestBody, ::File.join(__dir__, "schematic/types/upsert_user_sub_request_body")
    autoload :UsageBasedEntitlementRequestBody, ::File.join(__dir__, "schematic/types/usage_based_entitlement_request_body")
    autoload :WebFeatureUsageWebhookOutput, ::File.join(__dir__, "schematic/types/web_feature_usage_webhook_output")
    autoload :WebScheduledDowngradeWebhookOutput, ::File.join(__dir__, "schematic/types/web_scheduled_downgrade_webhook_output")
    autoload :WebhookEventResponseData, ::File.join(__dir__, "schematic/types/webhook_event_response_data")
    autoload :WebhookUrl, ::File.join(__dir__, "schematic/types/webhook_url")
  end

  module Accounts
    module Types
      autoload :ListAccountMembersParams, ::File.join(__dir__, "schematic/accounts/types/list_account_members_params")
      autoload :ListAccountMembersResponse, ::File.join(__dir__, "schematic/accounts/types/list_account_members_response")
      autoload :GetAccountMemberResponse, ::File.join(__dir__, "schematic/accounts/types/get_account_member_response")
      autoload :CountAccountMembersParams, ::File.join(__dir__, "schematic/accounts/types/count_account_members_params")
      autoload :CountAccountMembersResponse, ::File.join(__dir__, "schematic/accounts/types/count_account_members_response")
      autoload :ListApiKeysParams, ::File.join(__dir__, "schematic/accounts/types/list_api_keys_params")
      autoload :ListApiKeysResponse, ::File.join(__dir__, "schematic/accounts/types/list_api_keys_response")
      autoload :GetApiKeyResponse, ::File.join(__dir__, "schematic/accounts/types/get_api_key_response")
      autoload :CountApiKeysParams, ::File.join(__dir__, "schematic/accounts/types/count_api_keys_params")
      autoload :CountApiKeysResponse, ::File.join(__dir__, "schematic/accounts/types/count_api_keys_response")
      autoload :ListAuditLogsParams, ::File.join(__dir__, "schematic/accounts/types/list_audit_logs_params")
      autoload :ListAuditLogsResponse, ::File.join(__dir__, "schematic/accounts/types/list_audit_logs_response")
      autoload :GetAuditLogResponse, ::File.join(__dir__, "schematic/accounts/types/get_audit_log_response")
      autoload :CountAuditLogsParams, ::File.join(__dir__, "schematic/accounts/types/count_audit_logs_params")
      autoload :CountAuditLogsResponse, ::File.join(__dir__, "schematic/accounts/types/count_audit_logs_response")
      autoload :ListEnvironmentsParams, ::File.join(__dir__, "schematic/accounts/types/list_environments_params")
      autoload :ListEnvironmentsResponse, ::File.join(__dir__, "schematic/accounts/types/list_environments_response")
      autoload :GetEnvironmentResponse, ::File.join(__dir__, "schematic/accounts/types/get_environment_response")
      autoload :GetOnboardingStateResponse, ::File.join(__dir__, "schematic/accounts/types/get_onboarding_state_response")
      autoload :UpdateOnboardingStateResponse, ::File.join(__dir__, "schematic/accounts/types/update_onboarding_state_response")
      autoload :QuickstartResponse, ::File.join(__dir__, "schematic/accounts/types/quickstart_response")
      autoload :GetWhoAmIResponse, ::File.join(__dir__, "schematic/accounts/types/get_who_am_i_response")
    end
  end

  module Billing
    module Types
      autoload :ListCouponsParams, ::File.join(__dir__, "schematic/billing/types/list_coupons_params")
      autoload :ListCouponsResponse, ::File.join(__dir__, "schematic/billing/types/list_coupons_response")
      autoload :UpsertBillingCouponResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_coupon_response")
      autoload :DeleteBillingCouponResponse, ::File.join(__dir__, "schematic/billing/types/delete_billing_coupon_response")
      autoload :DeleteBillingCustomerResponse, ::File.join(__dir__, "schematic/billing/types/delete_billing_customer_response")
      autoload :UpsertBillingCustomerResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_customer_response")
      autoload :ListCustomersWithSubscriptionsParams, ::File.join(__dir__, "schematic/billing/types/list_customers_with_subscriptions_params")
      autoload :ListCustomersWithSubscriptionsResponse, ::File.join(__dir__, "schematic/billing/types/list_customers_with_subscriptions_response")
      autoload :CountCustomersParams, ::File.join(__dir__, "schematic/billing/types/count_customers_params")
      autoload :CountCustomersResponse, ::File.join(__dir__, "schematic/billing/types/count_customers_response")
      autoload :ListInvoicesParams, ::File.join(__dir__, "schematic/billing/types/list_invoices_params")
      autoload :ListInvoicesResponse, ::File.join(__dir__, "schematic/billing/types/list_invoices_response")
      autoload :UpsertInvoiceResponse, ::File.join(__dir__, "schematic/billing/types/upsert_invoice_response")
      autoload :DeleteBillingInvoiceResponse, ::File.join(__dir__, "schematic/billing/types/delete_billing_invoice_response")
      autoload :ListMetersParams, ::File.join(__dir__, "schematic/billing/types/list_meters_params")
      autoload :ListMetersResponse, ::File.join(__dir__, "schematic/billing/types/list_meters_response")
      autoload :UpsertBillingMeterResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_meter_response")
      autoload :ListPaymentMethodsParams, ::File.join(__dir__, "schematic/billing/types/list_payment_methods_params")
      autoload :ListPaymentMethodsResponse, ::File.join(__dir__, "schematic/billing/types/list_payment_methods_response")
      autoload :UpsertPaymentMethodResponse, ::File.join(__dir__, "schematic/billing/types/upsert_payment_method_response")
      autoload :DeletePaymentMethodByExternalIdResponse, ::File.join(__dir__, "schematic/billing/types/delete_payment_method_by_external_id_response")
      autoload :ListBillingPricesParams, ::File.join(__dir__, "schematic/billing/types/list_billing_prices_params")
      autoload :ListBillingPricesResponse, ::File.join(__dir__, "schematic/billing/types/list_billing_prices_response")
      autoload :UpsertBillingPriceResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_price_response")
      autoload :DeleteBillingProductResponse, ::File.join(__dir__, "schematic/billing/types/delete_billing_product_response")
      autoload :ListBillingProductPricesParams, ::File.join(__dir__, "schematic/billing/types/list_billing_product_prices_params")
      autoload :ListBillingProductPricesResponse, ::File.join(__dir__, "schematic/billing/types/list_billing_product_prices_response")
      autoload :DeleteProductPriceResponse, ::File.join(__dir__, "schematic/billing/types/delete_product_price_response")
      autoload :UpsertBillingProductResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_product_response")
      autoload :ListBillingProductsParams, ::File.join(__dir__, "schematic/billing/types/list_billing_products_params")
      autoload :ListBillingProductsResponse, ::File.join(__dir__, "schematic/billing/types/list_billing_products_response")
      autoload :CountBillingProductsParams, ::File.join(__dir__, "schematic/billing/types/count_billing_products_params")
      autoload :CountBillingProductsResponse, ::File.join(__dir__, "schematic/billing/types/count_billing_products_response")
      autoload :ListCompanyBillingProfilesParams, ::File.join(__dir__, "schematic/billing/types/list_company_billing_profiles_params")
      autoload :ListCompanyBillingProfilesResponse, ::File.join(__dir__, "schematic/billing/types/list_company_billing_profiles_response")
      autoload :UpdateCompanyBillingProfileResponse, ::File.join(__dir__, "schematic/billing/types/update_company_billing_profile_response")
      autoload :GetBillingSettingsResponse, ::File.join(__dir__, "schematic/billing/types/get_billing_settings_response")
      autoload :UpdateBillingSettingsResponse, ::File.join(__dir__, "schematic/billing/types/update_billing_settings_response")
      autoload :UpsertBillingSubscriptionResponse, ::File.join(__dir__, "schematic/billing/types/upsert_billing_subscription_response")
      autoload :GetCompanyNativeSubscriptionResponse, ::File.join(__dir__, "schematic/billing/types/get_company_native_subscription_response")
      autoload :ListBillingInvoicesParams, ::File.join(__dir__, "schematic/billing/types/list_billing_invoices_params")
      autoload :ListBillingInvoicesResponse, ::File.join(__dir__, "schematic/billing/types/list_billing_invoices_response")
      autoload :GetBillingInvoiceResponse, ::File.join(__dir__, "schematic/billing/types/get_billing_invoice_response")
      autoload :FinalizeNativeInvoiceResponse, ::File.join(__dir__, "schematic/billing/types/finalize_native_invoice_response")
      autoload :MarkBillingInvoicePaidResponse, ::File.join(__dir__, "schematic/billing/types/mark_billing_invoice_paid_response")
      autoload :VoidNativeInvoiceResponse, ::File.join(__dir__, "schematic/billing/types/void_native_invoice_response")
      autoload :CountBillingInvoicesParams, ::File.join(__dir__, "schematic/billing/types/count_billing_invoices_params")
      autoload :CountBillingInvoicesResponse, ::File.join(__dir__, "schematic/billing/types/count_billing_invoices_response")
    end
  end

  module Credits
    module Types
      autoload :ListBillingCreditsParams, ::File.join(__dir__, "schematic/credits/types/list_billing_credits_params")
      autoload :ListBillingCreditsResponse, ::File.join(__dir__, "schematic/credits/types/list_billing_credits_response")
      autoload :CreateBillingCreditResponse, ::File.join(__dir__, "schematic/credits/types/create_billing_credit_response")
      autoload :GetSingleBillingCreditResponse, ::File.join(__dir__, "schematic/credits/types/get_single_billing_credit_response")
      autoload :UpdateBillingCreditResponse, ::File.join(__dir__, "schematic/credits/types/update_billing_credit_response")
      autoload :SoftDeleteBillingCreditResponse, ::File.join(__dir__, "schematic/credits/types/soft_delete_billing_credit_response")
      autoload :ListCompanyCreditBalancesParams, ::File.join(__dir__, "schematic/credits/types/list_company_credit_balances_params")
      autoload :ListCompanyCreditBalancesResponse, ::File.join(__dir__, "schematic/credits/types/list_company_credit_balances_response")
      autoload :GetCreditBalanceTimeSeriesParams, ::File.join(__dir__, "schematic/credits/types/get_credit_balance_time_series_params")
      autoload :GetCreditBalanceTimeSeriesResponse, ::File.join(__dir__, "schematic/credits/types/get_credit_balance_time_series_response")
      autoload :ListCreditBundlesParams, ::File.join(__dir__, "schematic/credits/types/list_credit_bundles_params")
      autoload :ListCreditBundlesResponse, ::File.join(__dir__, "schematic/credits/types/list_credit_bundles_response")
      autoload :CreateCreditBundleResponse, ::File.join(__dir__, "schematic/credits/types/create_credit_bundle_response")
      autoload :GetCreditBundleResponse, ::File.join(__dir__, "schematic/credits/types/get_credit_bundle_response")
      autoload :UpdateCreditBundleDetailsResponse, ::File.join(__dir__, "schematic/credits/types/update_credit_bundle_details_response")
      autoload :DeleteCreditBundleResponse, ::File.join(__dir__, "schematic/credits/types/delete_credit_bundle_response")
      autoload :CountCreditBundlesParams, ::File.join(__dir__, "schematic/credits/types/count_credit_bundles_params")
      autoload :CountCreditBundlesResponse, ::File.join(__dir__, "schematic/credits/types/count_credit_bundles_response")
      autoload :CountBillingCreditsParams, ::File.join(__dir__, "schematic/credits/types/count_billing_credits_params")
      autoload :CountBillingCreditsResponse, ::File.join(__dir__, "schematic/credits/types/count_billing_credits_response")
      autoload :ZeroOutGrantResponse, ::File.join(__dir__, "schematic/credits/types/zero_out_grant_response")
      autoload :GrantBillingCreditsToCompanyResponse, ::File.join(__dir__, "schematic/credits/types/grant_billing_credits_to_company_response")
      autoload :CountCompanyGrantsParams, ::File.join(__dir__, "schematic/credits/types/count_company_grants_params")
      autoload :CountCompanyGrantsResponse, ::File.join(__dir__, "schematic/credits/types/count_company_grants_response")
      autoload :ListCompanyGrantsParams, ::File.join(__dir__, "schematic/credits/types/list_company_grants_params")
      autoload :ListCompanyGrantsResponse, ::File.join(__dir__, "schematic/credits/types/list_company_grants_response")
      autoload :CountBillingCreditsGrantsParams, ::File.join(__dir__, "schematic/credits/types/count_billing_credits_grants_params")
      autoload :CountBillingCreditsGrantsResponse, ::File.join(__dir__, "schematic/credits/types/count_billing_credits_grants_response")
      autoload :ListGrantsForCreditParams, ::File.join(__dir__, "schematic/credits/types/list_grants_for_credit_params")
      autoload :ListGrantsForCreditResponse, ::File.join(__dir__, "schematic/credits/types/list_grants_for_credit_response")
      autoload :AcquireCreditLeaseResponse, ::File.join(__dir__, "schematic/credits/types/acquire_credit_lease_response")
      autoload :ExtendCreditLeaseResponse, ::File.join(__dir__, "schematic/credits/types/extend_credit_lease_response")
      autoload :ReleaseCreditLeaseResponse, ::File.join(__dir__, "schematic/credits/types/release_credit_lease_response")
      autoload :ListBillingPlanCreditGrantsParams, ::File.join(__dir__, "schematic/credits/types/list_billing_plan_credit_grants_params")
      autoload :ListBillingPlanCreditGrantsResponse, ::File.join(__dir__, "schematic/credits/types/list_billing_plan_credit_grants_response")
      autoload :CreateBillingPlanCreditGrantResponse, ::File.join(__dir__, "schematic/credits/types/create_billing_plan_credit_grant_response")
      autoload :GetSingleBillingPlanCreditGrantResponse, ::File.join(__dir__, "schematic/credits/types/get_single_billing_plan_credit_grant_response")
      autoload :UpdateBillingPlanCreditGrantResponse, ::File.join(__dir__, "schematic/credits/types/update_billing_plan_credit_grant_response")
      autoload :DeleteBillingPlanCreditGrantParams, ::File.join(__dir__, "schematic/credits/types/delete_billing_plan_credit_grant_params")
      autoload :DeleteBillingPlanCreditGrantResponse, ::File.join(__dir__, "schematic/credits/types/delete_billing_plan_credit_grant_response")
      autoload :CountBillingPlanCreditGrantsParams, ::File.join(__dir__, "schematic/credits/types/count_billing_plan_credit_grants_params")
      autoload :CountBillingPlanCreditGrantsResponse, ::File.join(__dir__, "schematic/credits/types/count_billing_plan_credit_grants_response")
      autoload :ReserveCreditsResponse, ::File.join(__dir__, "schematic/credits/types/reserve_credits_response")
      autoload :ReleaseCreditReservationResponse, ::File.join(__dir__, "schematic/credits/types/release_credit_reservation_response")
      autoload :ListCreditSpendPoliciesParams, ::File.join(__dir__, "schematic/credits/types/list_credit_spend_policies_params")
      autoload :ListCreditSpendPoliciesResponse, ::File.join(__dir__, "schematic/credits/types/list_credit_spend_policies_response")
      autoload :CreateCreditSpendPolicyResponse, ::File.join(__dir__, "schematic/credits/types/create_credit_spend_policy_response")
      autoload :GetCreditSpendPolicyResponse, ::File.join(__dir__, "schematic/credits/types/get_credit_spend_policy_response")
      autoload :UpdateCreditSpendPolicyResponse, ::File.join(__dir__, "schematic/credits/types/update_credit_spend_policy_response")
      autoload :DeleteCreditSpendPolicyResponse, ::File.join(__dir__, "schematic/credits/types/delete_credit_spend_policy_response")
      autoload :CountCreditSpendPoliciesParams, ::File.join(__dir__, "schematic/credits/types/count_credit_spend_policies_params")
      autoload :CountCreditSpendPoliciesResponse, ::File.join(__dir__, "schematic/credits/types/count_credit_spend_policies_response")
      autoload :GetCreditSpendPolicyUsageParams, ::File.join(__dir__, "schematic/credits/types/get_credit_spend_policy_usage_params")
      autoload :GetCreditSpendPolicyUsageResponse, ::File.join(__dir__, "schematic/credits/types/get_credit_spend_policy_usage_response")
      autoload :ListCreditEventLedgerParams, ::File.join(__dir__, "schematic/credits/types/list_credit_event_ledger_params")
      autoload :ListCreditEventLedgerResponse, ::File.join(__dir__, "schematic/credits/types/list_credit_event_ledger_response")
      autoload :GetCreditEventLedgerEntryResponse, ::File.join(__dir__, "schematic/credits/types/get_credit_event_ledger_entry_response")
      autoload :CountCreditEventLedgerParams, ::File.join(__dir__, "schematic/credits/types/count_credit_event_ledger_params")
      autoload :CountCreditEventLedgerResponse, ::File.join(__dir__, "schematic/credits/types/count_credit_event_ledger_response")
    end
  end

  module Catalogs
    module Types
      autoload :ListCatalogsParams, ::File.join(__dir__, "schematic/catalogs/types/list_catalogs_params")
      autoload :ListCatalogsResponse, ::File.join(__dir__, "schematic/catalogs/types/list_catalogs_response")
      autoload :CreateCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/create_catalog_response")
      autoload :GetCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/get_catalog_response")
      autoload :UpdateCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/update_catalog_response")
      autoload :DeleteCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/delete_catalog_response")
      autoload :GetConfigurationResponse, ::File.join(__dir__, "schematic/catalogs/types/get_configuration_response")
      autoload :UpdateConfigurationResponse, ::File.join(__dir__, "schematic/catalogs/types/update_configuration_response")
      autoload :GetCreditBundlesInCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/get_credit_bundles_in_catalog_response")
      autoload :GetDerivedFeaturesResponse, ::File.join(__dir__, "schematic/catalogs/types/get_derived_features_response")
      autoload :GetPlansInCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/get_plans_in_catalog_response")
      autoload :GetPublicCatalogResponse, ::File.join(__dir__, "schematic/catalogs/types/get_public_catalog_response")
      autoload :GetPublicCatalogByIdResponse, ::File.join(__dir__, "schematic/catalogs/types/get_public_catalog_by_id_response")
    end
  end

  module Checkout
    module Types
      autoload :CheckoutInternalResponse, ::File.join(__dir__, "schematic/checkout/types/checkout_internal_response")
      autoload :GetCheckoutDataResponse, ::File.join(__dir__, "schematic/checkout/types/get_checkout_data_response")
      autoload :PreviewCheckoutInternalResponse, ::File.join(__dir__, "schematic/checkout/types/preview_checkout_internal_response")
      autoload :GetCompanyBillingDetailsResponse, ::File.join(__dir__, "schematic/checkout/types/get_company_billing_details_response")
      autoload :UpdateCompanyBillingDetailsResponse, ::File.join(__dir__, "schematic/checkout/types/update_company_billing_details_response")
      autoload :ManagePlanResponse, ::File.join(__dir__, "schematic/checkout/types/manage_plan_response")
      autoload :PreviewManagePlanResponse, ::File.join(__dir__, "schematic/checkout/types/preview_manage_plan_response")
      autoload :CancelSubscriptionResponse, ::File.join(__dir__, "schematic/checkout/types/cancel_subscription_response")
      autoload :UpdateCustomerSubscriptionTrialEndResponse, ::File.join(__dir__, "schematic/checkout/types/update_customer_subscription_trial_end_response")
    end
  end

  module Companies
    module Types
      autoload :ListCompaniesParams, ::File.join(__dir__, "schematic/companies/types/list_companies_params")
      autoload :ListCompaniesResponse, ::File.join(__dir__, "schematic/companies/types/list_companies_response")
      autoload :UpsertCompanyResponse, ::File.join(__dir__, "schematic/companies/types/upsert_company_response")
      autoload :GetCompanyResponse, ::File.join(__dir__, "schematic/companies/types/get_company_response")
      autoload :DeleteCompanyParams, ::File.join(__dir__, "schematic/companies/types/delete_company_params")
      autoload :DeleteCompanyResponse, ::File.join(__dir__, "schematic/companies/types/delete_company_response")
      autoload :GetCompanyInferenceCostParams, ::File.join(__dir__, "schematic/companies/types/get_company_inference_cost_params")
      autoload :GetCompanyInferenceCostResponse, ::File.join(__dir__, "schematic/companies/types/get_company_inference_cost_response")
      autoload :CountCompaniesParams, ::File.join(__dir__, "schematic/companies/types/count_companies_params")
      autoload :CountCompaniesResponse, ::File.join(__dir__, "schematic/companies/types/count_companies_response")
      autoload :CreateCompanyResponse, ::File.join(__dir__, "schematic/companies/types/create_company_response")
      autoload :DeleteCompanyByKeysResponse, ::File.join(__dir__, "schematic/companies/types/delete_company_by_keys_response")
      autoload :LookupCompanyParams, ::File.join(__dir__, "schematic/companies/types/lookup_company_params")
      autoload :LookupCompanyResponse, ::File.join(__dir__, "schematic/companies/types/lookup_company_response")
      autoload :GetCompanyBillingEntityParams, ::File.join(__dir__, "schematic/companies/types/get_company_billing_entity_params")
      autoload :GetCompanyBillingEntityResponse, ::File.join(__dir__, "schematic/companies/types/get_company_billing_entity_response")
      autoload :GetBillingEntityChildSubscriptionsParams, ::File.join(__dir__, "schematic/companies/types/get_billing_entity_child_subscriptions_params")
      autoload :GetBillingEntityChildSubscriptionsResponse, ::File.join(__dir__, "schematic/companies/types/get_billing_entity_child_subscriptions_response")
      autoload :ListCompanyMembershipsParams, ::File.join(__dir__, "schematic/companies/types/list_company_memberships_params")
      autoload :ListCompanyMembershipsResponse, ::File.join(__dir__, "schematic/companies/types/list_company_memberships_response")
      autoload :GetOrCreateCompanyMembershipResponse, ::File.join(__dir__, "schematic/companies/types/get_or_create_company_membership_response")
      autoload :DeleteCompanyMembershipResponse, ::File.join(__dir__, "schematic/companies/types/delete_company_membership_response")
      autoload :GetActiveCompanySubscriptionParams, ::File.join(__dir__, "schematic/companies/types/get_active_company_subscription_params")
      autoload :GetActiveCompanySubscriptionResponse, ::File.join(__dir__, "schematic/companies/types/get_active_company_subscription_response")
      autoload :UpsertCompanyTraitResponse, ::File.join(__dir__, "schematic/companies/types/upsert_company_trait_response")
      autoload :ListEntityKeyDefinitionsParams, ::File.join(__dir__, "schematic/companies/types/list_entity_key_definitions_params")
      autoload :ListEntityKeyDefinitionsResponse, ::File.join(__dir__, "schematic/companies/types/list_entity_key_definitions_response")
      autoload :DeleteEntityKeyDefinitionResponse, ::File.join(__dir__, "schematic/companies/types/delete_entity_key_definition_response")
      autoload :CountEntityKeyDefinitionsParams, ::File.join(__dir__, "schematic/companies/types/count_entity_key_definitions_params")
      autoload :CountEntityKeyDefinitionsResponse, ::File.join(__dir__, "schematic/companies/types/count_entity_key_definitions_response")
      autoload :CountEntityKeysParams, ::File.join(__dir__, "schematic/companies/types/count_entity_keys_params")
      autoload :CountEntityKeysResponse, ::File.join(__dir__, "schematic/companies/types/count_entity_keys_response")
      autoload :ListEntityTraitDefinitionsParams, ::File.join(__dir__, "schematic/companies/types/list_entity_trait_definitions_params")
      autoload :ListEntityTraitDefinitionsResponse, ::File.join(__dir__, "schematic/companies/types/list_entity_trait_definitions_response")
      autoload :GetOrCreateEntityTraitDefinitionResponse, ::File.join(__dir__, "schematic/companies/types/get_or_create_entity_trait_definition_response")
      autoload :GetEntityTraitDefinitionResponse, ::File.join(__dir__, "schematic/companies/types/get_entity_trait_definition_response")
      autoload :UpdateEntityTraitDefinitionResponse, ::File.join(__dir__, "schematic/companies/types/update_entity_trait_definition_response")
      autoload :DeleteEntityTraitDefinitionResponse, ::File.join(__dir__, "schematic/companies/types/delete_entity_trait_definition_response")
      autoload :GetEntityTraitDefinitionUsageResponse, ::File.join(__dir__, "schematic/companies/types/get_entity_trait_definition_usage_response")
      autoload :CountEntityTraitDefinitionsParams, ::File.join(__dir__, "schematic/companies/types/count_entity_trait_definitions_params")
      autoload :CountEntityTraitDefinitionsResponse, ::File.join(__dir__, "schematic/companies/types/count_entity_trait_definitions_response")
      autoload :GetEntityTraitValuesParams, ::File.join(__dir__, "schematic/companies/types/get_entity_trait_values_params")
      autoload :GetEntityTraitValuesResponse, ::File.join(__dir__, "schematic/companies/types/get_entity_trait_values_response")
      autoload :CountEntityTraitsParams, ::File.join(__dir__, "schematic/companies/types/count_entity_traits_params")
      autoload :CountEntityTraitsResponse, ::File.join(__dir__, "schematic/companies/types/count_entity_traits_response")
      autoload :ListPlanChangesParams, ::File.join(__dir__, "schematic/companies/types/list_plan_changes_params")
      autoload :ListPlanChangesResponse, ::File.join(__dir__, "schematic/companies/types/list_plan_changes_response")
      autoload :GetPlanChangeResponse, ::File.join(__dir__, "schematic/companies/types/get_plan_change_response")
      autoload :ListPlanTraitsParams, ::File.join(__dir__, "schematic/companies/types/list_plan_traits_params")
      autoload :ListPlanTraitsResponse, ::File.join(__dir__, "schematic/companies/types/list_plan_traits_response")
      autoload :GetPlanTraitResponse, ::File.join(__dir__, "schematic/companies/types/get_plan_trait_response")
      autoload :UpdatePlanTraitsBulkResponse, ::File.join(__dir__, "schematic/companies/types/update_plan_traits_bulk_response")
      autoload :CountPlanTraitsParams, ::File.join(__dir__, "schematic/companies/types/count_plan_traits_params")
      autoload :CountPlanTraitsResponse, ::File.join(__dir__, "schematic/companies/types/count_plan_traits_response")
      autoload :UpsertUserTraitResponse, ::File.join(__dir__, "schematic/companies/types/upsert_user_trait_response")
      autoload :ListUsersParams, ::File.join(__dir__, "schematic/companies/types/list_users_params")
      autoload :ListUsersResponse, ::File.join(__dir__, "schematic/companies/types/list_users_response")
      autoload :UpsertUserResponse, ::File.join(__dir__, "schematic/companies/types/upsert_user_response")
      autoload :GetUserResponse, ::File.join(__dir__, "schematic/companies/types/get_user_response")
      autoload :DeleteUserResponse, ::File.join(__dir__, "schematic/companies/types/delete_user_response")
      autoload :CountUsersParams, ::File.join(__dir__, "schematic/companies/types/count_users_params")
      autoload :CountUsersResponse, ::File.join(__dir__, "schematic/companies/types/count_users_response")
      autoload :CreateUserResponse, ::File.join(__dir__, "schematic/companies/types/create_user_response")
      autoload :DeleteUserByKeysResponse, ::File.join(__dir__, "schematic/companies/types/delete_user_by_keys_response")
      autoload :LookupUserParams, ::File.join(__dir__, "schematic/companies/types/lookup_user_params")
      autoload :LookupUserResponse, ::File.join(__dir__, "schematic/companies/types/lookup_user_response")
    end
  end

  module Entitlements
    module Types
      autoload :ListCompanyOverridesParams, ::File.join(__dir__, "schematic/entitlements/types/list_company_overrides_params")
      autoload :ListCompanyOverridesResponse, ::File.join(__dir__, "schematic/entitlements/types/list_company_overrides_response")
      autoload :CreateCompanyOverrideResponse, ::File.join(__dir__, "schematic/entitlements/types/create_company_override_response")
      autoload :GetCompanyOverrideResponse, ::File.join(__dir__, "schematic/entitlements/types/get_company_override_response")
      autoload :UpdateCompanyOverrideResponse, ::File.join(__dir__, "schematic/entitlements/types/update_company_override_response")
      autoload :DeleteCompanyOverrideResponse, ::File.join(__dir__, "schematic/entitlements/types/delete_company_override_response")
      autoload :CountCompanyOverridesParams, ::File.join(__dir__, "schematic/entitlements/types/count_company_overrides_params")
      autoload :CountCompanyOverridesResponse, ::File.join(__dir__, "schematic/entitlements/types/count_company_overrides_response")
      autoload :ListFeatureCompaniesParams, ::File.join(__dir__, "schematic/entitlements/types/list_feature_companies_params")
      autoload :ListFeatureCompaniesResponse, ::File.join(__dir__, "schematic/entitlements/types/list_feature_companies_response")
      autoload :CountFeatureCompaniesParams, ::File.join(__dir__, "schematic/entitlements/types/count_feature_companies_params")
      autoload :CountFeatureCompaniesResponse, ::File.join(__dir__, "schematic/entitlements/types/count_feature_companies_response")
      autoload :ListFeatureUsageParams, ::File.join(__dir__, "schematic/entitlements/types/list_feature_usage_params")
      autoload :ListFeatureUsageResponse, ::File.join(__dir__, "schematic/entitlements/types/list_feature_usage_response")
      autoload :ListFeatureUsageHistoryParams, ::File.join(__dir__, "schematic/entitlements/types/list_feature_usage_history_params")
      autoload :ListFeatureUsageHistoryResponse, ::File.join(__dir__, "schematic/entitlements/types/list_feature_usage_history_response")
      autoload :GetFeatureUsageTimeSeriesParams, ::File.join(__dir__, "schematic/entitlements/types/get_feature_usage_time_series_params")
      autoload :GetFeatureUsageTimeSeriesResponse, ::File.join(__dir__, "schematic/entitlements/types/get_feature_usage_time_series_response")
      autoload :CountFeatureUsageParams, ::File.join(__dir__, "schematic/entitlements/types/count_feature_usage_params")
      autoload :CountFeatureUsageResponse, ::File.join(__dir__, "schematic/entitlements/types/count_feature_usage_response")
      autoload :ListFeatureUsersParams, ::File.join(__dir__, "schematic/entitlements/types/list_feature_users_params")
      autoload :ListFeatureUsersResponse, ::File.join(__dir__, "schematic/entitlements/types/list_feature_users_response")
      autoload :CountFeatureUsersParams, ::File.join(__dir__, "schematic/entitlements/types/count_feature_users_params")
      autoload :CountFeatureUsersResponse, ::File.join(__dir__, "schematic/entitlements/types/count_feature_users_response")
      autoload :ListPlanEntitlementsParams, ::File.join(__dir__, "schematic/entitlements/types/list_plan_entitlements_params")
      autoload :ListPlanEntitlementsResponse, ::File.join(__dir__, "schematic/entitlements/types/list_plan_entitlements_response")
      autoload :CreatePlanEntitlementResponse, ::File.join(__dir__, "schematic/entitlements/types/create_plan_entitlement_response")
      autoload :GetPlanEntitlementResponse, ::File.join(__dir__, "schematic/entitlements/types/get_plan_entitlement_response")
      autoload :UpdatePlanEntitlementResponse, ::File.join(__dir__, "schematic/entitlements/types/update_plan_entitlement_response")
      autoload :DeletePlanEntitlementResponse, ::File.join(__dir__, "schematic/entitlements/types/delete_plan_entitlement_response")
      autoload :UpsertPlanEntitlementForBillingProductResponse, ::File.join(__dir__, "schematic/entitlements/types/upsert_plan_entitlement_for_billing_product_response")
      autoload :CountPlanEntitlementsParams, ::File.join(__dir__, "schematic/entitlements/types/count_plan_entitlements_params")
      autoload :CountPlanEntitlementsResponse, ::File.join(__dir__, "schematic/entitlements/types/count_plan_entitlements_response")
      autoload :DuplicatePlanEntitlementsResponse, ::File.join(__dir__, "schematic/entitlements/types/duplicate_plan_entitlements_response")
      autoload :GetFeatureUsageByCompanyParams, ::File.join(__dir__, "schematic/entitlements/types/get_feature_usage_by_company_params")
      autoload :GetFeatureUsageByCompanyResponse, ::File.join(__dir__, "schematic/entitlements/types/get_feature_usage_by_company_response")
      autoload :GetUserUsageByCompanyParams, ::File.join(__dir__, "schematic/entitlements/types/get_user_usage_by_company_params")
      autoload :GetUserUsageByCompanyResponse, ::File.join(__dir__, "schematic/entitlements/types/get_user_usage_by_company_response")
      autoload :GetCompanyUserUsageMetricsParams, ::File.join(__dir__, "schematic/entitlements/types/get_company_user_usage_metrics_params")
      autoload :GetCompanyUserUsageMetricsResponse, ::File.join(__dir__, "schematic/entitlements/types/get_company_user_usage_metrics_response")
      autoload :ListCompanyUserUsageParams, ::File.join(__dir__, "schematic/entitlements/types/list_company_user_usage_params")
      autoload :ListCompanyUserUsageResponse, ::File.join(__dir__, "schematic/entitlements/types/list_company_user_usage_response")
      autoload :CountCompanyUserUsageParams, ::File.join(__dir__, "schematic/entitlements/types/count_company_user_usage_params")
      autoload :CountCompanyUserUsageResponse, ::File.join(__dir__, "schematic/entitlements/types/count_company_user_usage_response")
      autoload :GetUserUsageDetailParams, ::File.join(__dir__, "schematic/entitlements/types/get_user_usage_detail_params")
      autoload :GetUserUsageDetailResponse, ::File.join(__dir__, "schematic/entitlements/types/get_user_usage_detail_response")
    end
  end

  module Plans
    module Types
      autoload :UpdateCompanyPlansResponse, ::File.join(__dir__, "schematic/plans/types/update_company_plans_response")
      autoload :ListCustomPlanBillingsParams, ::File.join(__dir__, "schematic/plans/types/list_custom_plan_billings_params")
      autoload :ListCustomPlanBillingsResponse, ::File.join(__dir__, "schematic/plans/types/list_custom_plan_billings_response")
      autoload :MarkCustomPlanBillingPaidResponse, ::File.join(__dir__, "schematic/plans/types/mark_custom_plan_billing_paid_response")
      autoload :RetryCustomPlanBillingResponse, ::File.join(__dir__, "schematic/plans/types/retry_custom_plan_billing_response")
      autoload :CreateCustomPlanResponse, ::File.join(__dir__, "schematic/plans/types/create_custom_plan_response")
      autoload :ListPlansParams, ::File.join(__dir__, "schematic/plans/types/list_plans_params")
      autoload :ListPlansResponse, ::File.join(__dir__, "schematic/plans/types/list_plans_response")
      autoload :CreatePlanResponse, ::File.join(__dir__, "schematic/plans/types/create_plan_response")
      autoload :GetPlanParams, ::File.join(__dir__, "schematic/plans/types/get_plan_params")
      autoload :GetPlanResponse, ::File.join(__dir__, "schematic/plans/types/get_plan_response")
      autoload :UpdatePlanResponse, ::File.join(__dir__, "schematic/plans/types/update_plan_response")
      autoload :DeletePlanResponse, ::File.join(__dir__, "schematic/plans/types/delete_plan_response")
      autoload :UpsertBillingProductPlanResponse, ::File.join(__dir__, "schematic/plans/types/upsert_billing_product_plan_response")
      autoload :UpsertPlanForBillingProductResponse, ::File.join(__dir__, "schematic/plans/types/upsert_plan_for_billing_product_response")
      autoload :ListBillingProductMatchCompaniesParams, ::File.join(__dir__, "schematic/plans/types/list_billing_product_match_companies_params")
      autoload :ListBillingProductMatchCompaniesResponse, ::File.join(__dir__, "schematic/plans/types/list_billing_product_match_companies_response")
      autoload :CountBillingProductMatchCompaniesParams, ::File.join(__dir__, "schematic/plans/types/count_billing_product_match_companies_params")
      autoload :CountBillingProductMatchCompaniesResponse, ::File.join(__dir__, "schematic/plans/types/count_billing_product_match_companies_response")
      autoload :CountPlansParams, ::File.join(__dir__, "schematic/plans/types/count_plans_params")
      autoload :CountPlansResponse, ::File.join(__dir__, "schematic/plans/types/count_plans_response")
      autoload :ListPlanIssuesParams, ::File.join(__dir__, "schematic/plans/types/list_plan_issues_params")
      autoload :ListPlanIssuesResponse, ::File.join(__dir__, "schematic/plans/types/list_plan_issues_response")
      autoload :DeletePlanVersionParams, ::File.join(__dir__, "schematic/plans/types/delete_plan_version_params")
      autoload :DeletePlanVersionResponse, ::File.join(__dir__, "schematic/plans/types/delete_plan_version_response")
      autoload :GetPlanVersionDiffParams, ::File.join(__dir__, "schematic/plans/types/get_plan_version_diff_params")
      autoload :GetPlanVersionDiffResponse, ::File.join(__dir__, "schematic/plans/types/get_plan_version_diff_response")
      autoload :PublishPlanVersionResponse, ::File.join(__dir__, "schematic/plans/types/publish_plan_version_response")
      autoload :PreviewPublishPlanVersionResponse, ::File.join(__dir__, "schematic/plans/types/preview_publish_plan_version_response")
    end
  end

  module Components
    module Types
      autoload :ListComponentsParams, ::File.join(__dir__, "schematic/components/types/list_components_params")
      autoload :ListComponentsResponse, ::File.join(__dir__, "schematic/components/types/list_components_response")
      autoload :CreateComponentResponse, ::File.join(__dir__, "schematic/components/types/create_component_response")
      autoload :GetComponentResponse, ::File.join(__dir__, "schematic/components/types/get_component_response")
      autoload :UpdateComponentResponse, ::File.join(__dir__, "schematic/components/types/update_component_response")
      autoload :DeleteComponentResponse, ::File.join(__dir__, "schematic/components/types/delete_component_response")
      autoload :BindCatalogResponse, ::File.join(__dir__, "schematic/components/types/bind_catalog_response")
      autoload :CountComponentsParams, ::File.join(__dir__, "schematic/components/types/count_components_params")
      autoload :CountComponentsResponse, ::File.join(__dir__, "schematic/components/types/count_components_response")
      autoload :PreviewComponentDataParams, ::File.join(__dir__, "schematic/components/types/preview_component_data_params")
      autoload :PreviewComponentDataResponse, ::File.join(__dir__, "schematic/components/types/preview_component_data_response")
    end
  end

  module Planbundle
    module Types
      autoload :CreateCustomPlanBundleResponse, ::File.join(__dir__, "schematic/planbundle/types/create_custom_plan_bundle_response")
      autoload :CreatePlanBundleResponse, ::File.join(__dir__, "schematic/planbundle/types/create_plan_bundle_response")
      autoload :UpdatePlanBundleResponse, ::File.join(__dir__, "schematic/planbundle/types/update_plan_bundle_response")
    end
  end

  module Dataexports
    module Types
      autoload :ListDataExportsParams, ::File.join(__dir__, "schematic/dataexports/types/list_data_exports_params")
      autoload :ListDataExportsResponse, ::File.join(__dir__, "schematic/dataexports/types/list_data_exports_response")
      autoload :CreateDataExportResponse, ::File.join(__dir__, "schematic/dataexports/types/create_data_export_response")
      autoload :GetDataExportResponse, ::File.join(__dir__, "schematic/dataexports/types/get_data_export_response")
    end
  end

  module Events
    module Types
      autoload :CreateEventBatchResponse, ::File.join(__dir__, "schematic/events/types/create_event_batch_response")
      autoload :GetEventSummariesParams, ::File.join(__dir__, "schematic/events/types/get_event_summaries_params")
      autoload :GetEventSummariesResponse, ::File.join(__dir__, "schematic/events/types/get_event_summaries_response")
      autoload :ListEventsParams, ::File.join(__dir__, "schematic/events/types/list_events_params")
      autoload :ListEventsResponse, ::File.join(__dir__, "schematic/events/types/list_events_response")
      autoload :CreateEventResponse, ::File.join(__dir__, "schematic/events/types/create_event_response")
      autoload :GetEventResponse, ::File.join(__dir__, "schematic/events/types/get_event_response")
      autoload :GetOtlpEnvironmentSettingsResponse, ::File.join(__dir__, "schematic/events/types/get_otlp_environment_settings_response")
      autoload :UpsertOtlpEnvironmentSettingsResponse, ::File.join(__dir__, "schematic/events/types/upsert_otlp_environment_settings_response")
      autoload :DeleteOtlpEnvironmentSettingsResponse, ::File.join(__dir__, "schematic/events/types/delete_otlp_environment_settings_response")
      autoload :GetSegmentIntegrationStatusResponse, ::File.join(__dir__, "schematic/events/types/get_segment_integration_status_response")
    end
  end

  module Features
    module Types
      autoload :ListFeaturesParams, ::File.join(__dir__, "schematic/features/types/list_features_params")
      autoload :ListFeaturesResponse, ::File.join(__dir__, "schematic/features/types/list_features_response")
      autoload :CreateFeatureResponse, ::File.join(__dir__, "schematic/features/types/create_feature_response")
      autoload :GetFeatureResponse, ::File.join(__dir__, "schematic/features/types/get_feature_response")
      autoload :UpdateFeatureResponse, ::File.join(__dir__, "schematic/features/types/update_feature_response")
      autoload :DeleteFeatureResponse, ::File.join(__dir__, "schematic/features/types/delete_feature_response")
      autoload :UpsertFeatureForBillingProductResponse, ::File.join(__dir__, "schematic/features/types/upsert_feature_for_billing_product_response")
      autoload :CountFeaturesParams, ::File.join(__dir__, "schematic/features/types/count_features_params")
      autoload :CountFeaturesResponse, ::File.join(__dir__, "schematic/features/types/count_features_response")
      autoload :ListFlagsParams, ::File.join(__dir__, "schematic/features/types/list_flags_params")
      autoload :ListFlagsResponse, ::File.join(__dir__, "schematic/features/types/list_flags_response")
      autoload :CreateFlagResponse, ::File.join(__dir__, "schematic/features/types/create_flag_response")
      autoload :GetFlagResponse, ::File.join(__dir__, "schematic/features/types/get_flag_response")
      autoload :UpdateFlagResponse, ::File.join(__dir__, "schematic/features/types/update_flag_response")
      autoload :DeleteFlagResponse, ::File.join(__dir__, "schematic/features/types/delete_flag_response")
      autoload :UpdateFlagRulesResponse, ::File.join(__dir__, "schematic/features/types/update_flag_rules_response")
      autoload :CheckFlagResponse, ::File.join(__dir__, "schematic/features/types/check_flag_response")
      autoload :CheckAndReserveFlagResponse, ::File.join(__dir__, "schematic/features/types/check_and_reserve_flag_response")
      autoload :CheckFlagsResponse, ::File.join(__dir__, "schematic/features/types/check_flags_response")
      autoload :CheckFlagsBulkResponse, ::File.join(__dir__, "schematic/features/types/check_flags_bulk_response")
      autoload :CountFlagsParams, ::File.join(__dir__, "schematic/features/types/count_flags_params")
      autoload :CountFlagsResponse, ::File.join(__dir__, "schematic/features/types/count_flags_response")
    end
  end

  module Insights
    module Types
      autoload :GetActivityParams, ::File.join(__dir__, "schematic/insights/types/get_activity_params")
      autoload :GetActivityResponse, ::File.join(__dir__, "schematic/insights/types/get_activity_response")
      autoload :GetEnvironmentFeatureUsageTimeSeriesParams, ::File.join(__dir__, "schematic/insights/types/get_environment_feature_usage_time_series_params")
      autoload :GetEnvironmentFeatureUsageTimeSeriesResponse, ::File.join(__dir__, "schematic/insights/types/get_environment_feature_usage_time_series_response")
      autoload :GetPlanGrowthParams, ::File.join(__dir__, "schematic/insights/types/get_plan_growth_params")
      autoload :GetPlanGrowthResponse, ::File.join(__dir__, "schematic/insights/types/get_plan_growth_response")
      autoload :GetSummaryResponse, ::File.join(__dir__, "schematic/insights/types/get_summary_response")
      autoload :GetTopFeaturesByUsageParams, ::File.join(__dir__, "schematic/insights/types/get_top_features_by_usage_params")
      autoload :GetTopFeaturesByUsageResponse, ::File.join(__dir__, "schematic/insights/types/get_top_features_by_usage_response")
      autoload :GetEnvironmentTraitUsageTimeSeriesParams, ::File.join(__dir__, "schematic/insights/types/get_environment_trait_usage_time_series_params")
      autoload :GetEnvironmentTraitUsageTimeSeriesResponse, ::File.join(__dir__, "schematic/insights/types/get_environment_trait_usage_time_series_response")
    end
  end

  module Integrationsapi
    module Types
      autoload :RunIntegrationResponse, ::File.join(__dir__, "schematic/integrationsapi/types/run_integration_response")
      autoload :ListIntegrationsParams, ::File.join(__dir__, "schematic/integrationsapi/types/list_integrations_params")
      autoload :ListIntegrationsResponse, ::File.join(__dir__, "schematic/integrationsapi/types/list_integrations_response")
      autoload :GetIntegrationWebhookUrlResponse, ::File.join(__dir__, "schematic/integrationsapi/types/get_integration_webhook_url_response")
      autoload :InstallIntegrationResponse, ::File.join(__dir__, "schematic/integrationsapi/types/install_integration_response")
      autoload :StartDataImportResponse, ::File.join(__dir__, "schematic/integrationsapi/types/start_data_import_response")
      autoload :LoadSampleDataSetResponse, ::File.join(__dir__, "schematic/integrationsapi/types/load_sample_data_set_response")
      autoload :GetStripeSandboxClaimLinkResponse, ::File.join(__dir__, "schematic/integrationsapi/types/get_stripe_sandbox_claim_link_response")
      autoload :GetStripeSandboxKeysResponse, ::File.join(__dir__, "schematic/integrationsapi/types/get_stripe_sandbox_keys_response")
      autoload :ClaimStripeSandboxKeysResponse, ::File.join(__dir__, "schematic/integrationsapi/types/claim_stripe_sandbox_keys_response")
      autoload :AssumeStripeInstalledResponse, ::File.join(__dir__, "schematic/integrationsapi/types/assume_stripe_installed_response")
      autoload :InstallStripeResponse, ::File.join(__dir__, "schematic/integrationsapi/types/install_stripe_response")
      autoload :InstallStripeClaimableSandboxResponse, ::File.join(__dir__, "schematic/integrationsapi/types/install_stripe_claimable_sandbox_response")
      autoload :ListStripeSandboxCountriesResponse, ::File.join(__dir__, "schematic/integrationsapi/types/list_stripe_sandbox_countries_response")
      autoload :UninstallIntegrationResponse, ::File.join(__dir__, "schematic/integrationsapi/types/uninstall_integration_response")
    end
  end

  module Licenses
    module Types
      autoload :ListLicensesParams, ::File.join(__dir__, "schematic/licenses/types/list_licenses_params")
      autoload :ListLicensesResponse, ::File.join(__dir__, "schematic/licenses/types/list_licenses_response")
      autoload :GetSingleLicenseResponse, ::File.join(__dir__, "schematic/licenses/types/get_single_license_response")
      autoload :CountLicensesParams, ::File.join(__dir__, "schematic/licenses/types/count_licenses_params")
      autoload :CountLicensesResponse, ::File.join(__dir__, "schematic/licenses/types/count_licenses_response")
    end
  end

  module Plangroups
    module Types
      autoload :GetPlanGroupParams, ::File.join(__dir__, "schematic/plangroups/types/get_plan_group_params")
      autoload :GetPlanGroupResponse, ::File.join(__dir__, "schematic/plangroups/types/get_plan_group_response")
      autoload :CreatePlanGroupResponse, ::File.join(__dir__, "schematic/plangroups/types/create_plan_group_response")
      autoload :UpdatePlanGroupResponse, ::File.join(__dir__, "schematic/plangroups/types/update_plan_group_response")
    end
  end

  module Planmigrations
    module Types
      autoload :ListCompanyMigrationsParams, ::File.join(__dir__, "schematic/planmigrations/types/list_company_migrations_params")
      autoload :ListCompanyMigrationsResponse, ::File.join(__dir__, "schematic/planmigrations/types/list_company_migrations_response")
      autoload :RetryCompanyMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/retry_company_migration_response")
      autoload :CountCompanyMigrationsParams, ::File.join(__dir__, "schematic/planmigrations/types/count_company_migrations_params")
      autoload :CountCompanyMigrationsResponse, ::File.join(__dir__, "schematic/planmigrations/types/count_company_migrations_response")
      autoload :ListMigrationsParams, ::File.join(__dir__, "schematic/planmigrations/types/list_migrations_params")
      autoload :ListMigrationsResponse, ::File.join(__dir__, "schematic/planmigrations/types/list_migrations_response")
      autoload :CreateMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/create_migration_response")
      autoload :GetMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/get_migration_response")
      autoload :CancelMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/cancel_migration_response")
      autoload :CompleteMigrationNowResponse, ::File.join(__dir__, "schematic/planmigrations/types/complete_migration_now_response")
      autoload :RetryMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/retry_migration_response")
      autoload :CountMigrationsParams, ::File.join(__dir__, "schematic/planmigrations/types/count_migrations_params")
      autoload :CountMigrationsResponse, ::File.join(__dir__, "schematic/planmigrations/types/count_migrations_response")
      autoload :PreviewMigrationResponse, ::File.join(__dir__, "schematic/planmigrations/types/preview_migration_response")
    end
  end

  module Componentspublic
    module Types
      autoload :GetPublicPlansResponse, ::File.join(__dir__, "schematic/componentspublic/types/get_public_plans_response")
    end
  end

  module Scheduledcheckout
    module Types
      autoload :ListScheduledCheckoutsParams, ::File.join(__dir__, "schematic/scheduledcheckout/types/list_scheduled_checkouts_params")
      autoload :ListScheduledCheckoutsResponse, ::File.join(__dir__, "schematic/scheduledcheckout/types/list_scheduled_checkouts_response")
      autoload :CreateScheduledCheckoutResponse, ::File.join(__dir__, "schematic/scheduledcheckout/types/create_scheduled_checkout_response")
      autoload :GetScheduledCheckoutResponse, ::File.join(__dir__, "schematic/scheduledcheckout/types/get_scheduled_checkout_response")
      autoload :UpdateScheduledCheckoutResponse, ::File.join(__dir__, "schematic/scheduledcheckout/types/update_scheduled_checkout_response")
    end
  end

  module Accesstokens
    module Types
      autoload :IssueTemporaryAccessTokenResponse, ::File.join(__dir__, "schematic/accesstokens/types/issue_temporary_access_token_response")
    end
  end

  module Webhooks
    module Types
      autoload :ListWebhookEventsParams, ::File.join(__dir__, "schematic/webhooks/types/list_webhook_events_params")
      autoload :ListWebhookEventsResponse, ::File.join(__dir__, "schematic/webhooks/types/list_webhook_events_response")
      autoload :GetWebhookEventResponse, ::File.join(__dir__, "schematic/webhooks/types/get_webhook_event_response")
      autoload :CountWebhookEventsParams, ::File.join(__dir__, "schematic/webhooks/types/count_webhook_events_params")
      autoload :CountWebhookEventsResponse, ::File.join(__dir__, "schematic/webhooks/types/count_webhook_events_response")
      autoload :ListWebhooksParams, ::File.join(__dir__, "schematic/webhooks/types/list_webhooks_params")
      autoload :ListWebhooksResponse, ::File.join(__dir__, "schematic/webhooks/types/list_webhooks_response")
      autoload :CreateWebhookResponse, ::File.join(__dir__, "schematic/webhooks/types/create_webhook_response")
      autoload :GetWebhookResponse, ::File.join(__dir__, "schematic/webhooks/types/get_webhook_response")
      autoload :UpdateWebhookResponse, ::File.join(__dir__, "schematic/webhooks/types/update_webhook_response")
      autoload :DeleteWebhookResponse, ::File.join(__dir__, "schematic/webhooks/types/delete_webhook_response")
      autoload :SendTestWebhookActionResponse, ::File.join(__dir__, "schematic/webhooks/types/send_test_webhook_action_response")
      autoload :CountWebhooksParams, ::File.join(__dir__, "schematic/webhooks/types/count_webhooks_params")
      autoload :CountWebhooksResponse, ::File.join(__dir__, "schematic/webhooks/types/count_webhooks_response")
    end
  end
end
