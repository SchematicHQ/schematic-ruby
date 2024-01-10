=begin
#Schematic API

#Schematic API

The version of the OpenAPI document: 0.1

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.6.0

=end

# Common files
require 'schematic/api_client'
require 'schematic/api_error'
require 'schematic/version'
require 'schematic/configuration'

# Models
require 'schematic/models/api_error'
require 'schematic/models/api_key_create_response_data'
require 'schematic/models/api_key_request_list_response_data'
require 'schematic/models/api_key_request_response_data'
require 'schematic/models/api_key_response_data'
require 'schematic/models/audience_request_body'
require 'schematic/models/billing_period_response_data'
require 'schematic/models/check_flag_output_with_flag_key'
require 'schematic/models/check_flag_request_body'
require 'schematic/models/check_flag_response'
require 'schematic/models/check_flag_response_data'
require 'schematic/models/check_flags_response'
require 'schematic/models/check_flags_response_data'
require 'schematic/models/company_detail_response_data'
require 'schematic/models/company_membership_detail_response_data'
require 'schematic/models/company_membership_response_data'
require 'schematic/models/company_plan_response_data'
require 'schematic/models/company_response_data'
require 'schematic/models/count_api_keys_params'
require 'schematic/models/count_api_keys_response'
require 'schematic/models/count_api_requests_params'
require 'schematic/models/count_api_requests_response'
require 'schematic/models/count_companies_audience_response'
require 'schematic/models/count_event_types_params'
require 'schematic/models/count_event_types_response'
require 'schematic/models/count_events_params'
require 'schematic/models/count_events_response'
require 'schematic/models/count_flag_checks_params'
require 'schematic/models/count_flag_checks_response'
require 'schematic/models/count_flag_values_params'
require 'schematic/models/count_flag_values_response'
require 'schematic/models/count_response'
require 'schematic/models/count_users_audience_response'
require 'schematic/models/create_api_key_request_body'
require 'schematic/models/create_api_key_response'
require 'schematic/models/create_company_membership_response'
require 'schematic/models/create_company_response'
require 'schematic/models/create_environment_request_body'
require 'schematic/models/create_environment_response'
require 'schematic/models/create_event_request_body'
require 'schematic/models/create_event_response'
require 'schematic/models/create_feature_request_body'
require 'schematic/models/create_feature_response'
require 'schematic/models/create_flag_request_body'
require 'schematic/models/create_flag_response'
require 'schematic/models/create_or_update_condition_group_request_body'
require 'schematic/models/create_or_update_condition_request_body'
require 'schematic/models/create_or_update_flag_request_body'
require 'schematic/models/create_or_update_rule_request_body'
require 'schematic/models/create_plan_request_body'
require 'schematic/models/create_plan_response'
require 'schematic/models/create_rule_request_body'
require 'schematic/models/create_rule_response'
require 'schematic/models/create_user_response'
require 'schematic/models/delete_api_key_response'
require 'schematic/models/delete_company_membership_response'
require 'schematic/models/delete_environment_response'
require 'schematic/models/delete_feature_response'
require 'schematic/models/delete_flag_response'
require 'schematic/models/delete_plan_response'
require 'schematic/models/delete_response'
require 'schematic/models/entity_flag_value_response_data'
require 'schematic/models/entity_key_response_data'
require 'schematic/models/entity_trait_definition_response_data'
require 'schematic/models/environment_detail_response_data'
require 'schematic/models/environment_response_data'
require 'schematic/models/event_body'
require 'schematic/models/event_body_identify'
require 'schematic/models/event_body_identify_company'
require 'schematic/models/event_body_track'
require 'schematic/models/event_response_data'
require 'schematic/models/event_summary_response_data'
require 'schematic/models/feature_detail_response_data'
require 'schematic/models/feature_response_data'
require 'schematic/models/flag_check_log_detail_response_data'
require 'schematic/models/flag_check_log_response_data'
require 'schematic/models/flag_detail_response_data'
require 'schematic/models/flag_response_data'
require 'schematic/models/get_api_key_response'
require 'schematic/models/get_api_request_response'
require 'schematic/models/get_companies_audience_response'
require 'schematic/models/get_company_response'
require 'schematic/models/get_environment_response'
require 'schematic/models/get_event_response'
require 'schematic/models/get_event_type_response'
require 'schematic/models/get_feature_response'
require 'schematic/models/get_flag_check_response'
require 'schematic/models/get_flag_response'
require 'schematic/models/get_or_create_company_membership_request_body'
require 'schematic/models/get_plan_response'
require 'schematic/models/get_rule_response'
require 'schematic/models/get_user_response'
require 'schematic/models/get_users_audience_response'
require 'schematic/models/latest_flag_checks_params'
require 'schematic/models/latest_flag_checks_response'
require 'schematic/models/list_api_keys_params'
require 'schematic/models/list_api_keys_response'
require 'schematic/models/list_api_requests_params'
require 'schematic/models/list_api_requests_response'
require 'schematic/models/list_companies_params'
require 'schematic/models/list_companies_response'
require 'schematic/models/list_company_memberships_params'
require 'schematic/models/list_company_memberships_response'
require 'schematic/models/list_company_plans_params'
require 'schematic/models/list_company_plans_response'
require 'schematic/models/list_event_types_params'
require 'schematic/models/list_event_types_response'
require 'schematic/models/list_events_params'
require 'schematic/models/list_events_response'
require 'schematic/models/list_features_params'
require 'schematic/models/list_features_response'
require 'schematic/models/list_flag_checks_params'
require 'schematic/models/list_flag_checks_response'
require 'schematic/models/list_flag_values_params'
require 'schematic/models/list_flag_values_response'
require 'schematic/models/list_flags_params'
require 'schematic/models/list_flags_response'
require 'schematic/models/list_metric_counts_hourly_params'
require 'schematic/models/list_metric_counts_hourly_response'
require 'schematic/models/list_metric_counts_params'
require 'schematic/models/list_metric_counts_response'
require 'schematic/models/list_plans_params'
require 'schematic/models/list_plans_response'
require 'schematic/models/list_users_params'
require 'schematic/models/list_users_response'
require 'schematic/models/metric_counts_hourly_response_data'
require 'schematic/models/pagination_filter'
require 'schematic/models/plan_response_data'
require 'schematic/models/rule_condition_group_detail_response_data'
require 'schematic/models/rule_condition_group_response_data'
require 'schematic/models/rule_condition_response_data'
require 'schematic/models/rule_detail_response_data'
require 'schematic/models/rule_response_data'
require 'schematic/models/update_api_key_request_body'
require 'schematic/models/update_api_key_response'
require 'schematic/models/update_audience_request_body'
require 'schematic/models/update_entity_trait_definition_request_body'
require 'schematic/models/update_entity_trait_definition_response'
require 'schematic/models/update_environment_request_body'
require 'schematic/models/update_environment_response'
require 'schematic/models/update_feature_request_body'
require 'schematic/models/update_feature_response'
require 'schematic/models/update_flag_response'
require 'schematic/models/update_plan_audience_response'
require 'schematic/models/update_plan_request_body'
require 'schematic/models/update_plan_response'
require 'schematic/models/update_rule_request_body'
require 'schematic/models/update_rule_response'
require 'schematic/models/upsert_billing_period_request_body'
require 'schematic/models/upsert_billing_period_response'
require 'schematic/models/upsert_company_request_body'
require 'schematic/models/upsert_user_request_body'
require 'schematic/models/upsert_user_sub_request_body'
require 'schematic/models/user_detail_response_data'
require 'schematic/models/user_response_data'

# APIs
require 'schematic/api/accounts_api'
require 'schematic/api/companies_api'
require 'schematic/api/events_api'
require 'schematic/api/features_api'
require 'schematic/api/plans_api'

module Schematic
  class << self
    # Customize default settings for the SDK using block.
    #   Schematic.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
