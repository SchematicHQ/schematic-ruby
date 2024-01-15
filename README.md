# schematic

Schematic - the Ruby gem for the Schematic API

Schematic API

This SDK is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 0.1
- Package version: 1.0.0
- Build package: org.openapitools.codegen.languages.RubyClientCodegen

## Installation

### Build a gem

To build the Ruby code into a gem:

```shell
gem build schematic.gemspec
```

Then either install the gem locally:

```shell
gem install ./schematic-1.0.0.gem
```

(for development, run `gem install --dev ./schematic-1.0.0.gem` to install the development dependencies)

or publish the gem to a gem hosting service, e.g. [RubyGems](https://rubygems.org/).

Finally add this to the Gemfile:

    gem 'schematic', '~> 1.0.0'

### Install from Git

If the Ruby gem is hosted at a git repository: https://github.com/SchematicHQ/schematic-ruby, then add the following in the Gemfile:

    gem 'schematic', :git => 'https://github.com/SchematicHQ/schematic-ruby.git'

### Include the Ruby code directly

Include the Ruby code directly using `-I` as follows:

```shell
ruby -Ilib script.rb
```

## Getting Started

Please follow the [installation](#installation) procedure and then run the following code:

```ruby
# Load the gem
require 'schematic'

# Setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::AccountsApi.new
require_environment = true # Boolean | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  environment_id: 'environment_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56 # Integer | Page offset (default 0)
}

begin
  #Count api keys
  result = api_instance.count_api_keys(require_environment, opts)
  p result
rescue Schematic::ApiError => e
  puts "Exception when calling AccountsApi->count_api_keys: #{e}"
end

```

## Documentation for API Endpoints

All URIs are relative to *https://api.schematichq.com*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*Schematic::AccountsApi* | [**count_api_keys**](docs/AccountsApi.md#count_api_keys) | **GET** /api-keys/count | Count api keys
*Schematic::AccountsApi* | [**count_api_requests**](docs/AccountsApi.md#count_api_requests) | **GET** /api-requests/count | Count api requests
*Schematic::AccountsApi* | [**create_api_key**](docs/AccountsApi.md#create_api_key) | **POST** /api-keys | Create api key
*Schematic::AccountsApi* | [**create_environment**](docs/AccountsApi.md#create_environment) | **POST** /environments | Create environment
*Schematic::AccountsApi* | [**delete_api_key**](docs/AccountsApi.md#delete_api_key) | **DELETE** /api-keys/{api_key_id} | Delete api key
*Schematic::AccountsApi* | [**delete_environment**](docs/AccountsApi.md#delete_environment) | **DELETE** /environments/{environment_id} | Delete environment
*Schematic::AccountsApi* | [**get_api_key**](docs/AccountsApi.md#get_api_key) | **GET** /api-keys/{api_key_id} | Get api key
*Schematic::AccountsApi* | [**get_api_request**](docs/AccountsApi.md#get_api_request) | **GET** /api-requests/{api_request_id} | Get api request
*Schematic::AccountsApi* | [**get_environment**](docs/AccountsApi.md#get_environment) | **GET** /environments/{environment_id} | Get environment
*Schematic::AccountsApi* | [**list_api_keys**](docs/AccountsApi.md#list_api_keys) | **GET** /api-keys | List api keys
*Schematic::AccountsApi* | [**list_api_requests**](docs/AccountsApi.md#list_api_requests) | **GET** /api-requests | List api requests
*Schematic::AccountsApi* | [**update_api_key**](docs/AccountsApi.md#update_api_key) | **PUT** /api-keys/{api_key_id} | Update api key
*Schematic::AccountsApi* | [**update_environment**](docs/AccountsApi.md#update_environment) | **PUT** /environments/{environment_id} | Update environment
*Schematic::CompaniesApi* | [**create_company**](docs/CompaniesApi.md#create_company) | **POST** /companies | Create company
*Schematic::CompaniesApi* | [**create_company_membership**](docs/CompaniesApi.md#create_company_membership) | **POST** /company-memberships | Create company membership
*Schematic::CompaniesApi* | [**create_user**](docs/CompaniesApi.md#create_user) | **POST** /users | Create user
*Schematic::CompaniesApi* | [**delete_company_membership**](docs/CompaniesApi.md#delete_company_membership) | **DELETE** /company-memberships/{company_membership_id} | Delete company membership
*Schematic::CompaniesApi* | [**get_company**](docs/CompaniesApi.md#get_company) | **GET** /companies/{company_id} | Get company
*Schematic::CompaniesApi* | [**get_user**](docs/CompaniesApi.md#get_user) | **GET** /users/{user_id} | Get user
*Schematic::CompaniesApi* | [**list_companies**](docs/CompaniesApi.md#list_companies) | **GET** /companies | List companies
*Schematic::CompaniesApi* | [**list_company_memberships**](docs/CompaniesApi.md#list_company_memberships) | **GET** /company-memberships | List company memberships
*Schematic::CompaniesApi* | [**list_company_plans**](docs/CompaniesApi.md#list_company_plans) | **GET** /company-plans | List company plans
*Schematic::CompaniesApi* | [**list_users**](docs/CompaniesApi.md#list_users) | **GET** /users | List users
*Schematic::CompaniesApi* | [**update_entity_trait_definition**](docs/CompaniesApi.md#update_entity_trait_definition) | **PUT** /entity-trait-definitions/{entity_trait_definition_id} | Update entity trait definition
*Schematic::EventsApi* | [**count_event_types**](docs/EventsApi.md#count_event_types) | **GET** /event-types/count | Count event types
*Schematic::EventsApi* | [**count_events**](docs/EventsApi.md#count_events) | **GET** /events/count | Count events
*Schematic::EventsApi* | [**create_event**](docs/EventsApi.md#create_event) | **POST** /events | Create event
*Schematic::EventsApi* | [**get_event**](docs/EventsApi.md#get_event) | **GET** /events/{event_id} | Get event
*Schematic::EventsApi* | [**get_event_type**](docs/EventsApi.md#get_event_type) | **GET** /event-types/{key} | Get event type
*Schematic::EventsApi* | [**list_event_types**](docs/EventsApi.md#list_event_types) | **GET** /event-types | List event types
*Schematic::EventsApi* | [**list_events**](docs/EventsApi.md#list_events) | **GET** /events | List events
*Schematic::EventsApi* | [**list_metric_counts**](docs/EventsApi.md#list_metric_counts) | **GET** /metric-counts | List metric counts
*Schematic::EventsApi* | [**list_metric_counts_hourly**](docs/EventsApi.md#list_metric_counts_hourly) | **GET** /metric-counts-hourly | List metric counts hourly
*Schematic::FeaturesApi* | [**check_flag**](docs/FeaturesApi.md#check_flag) | **POST** /flags/{key}/check | Check flag
*Schematic::FeaturesApi* | [**check_flags**](docs/FeaturesApi.md#check_flags) | **POST** /flags/check | Check flags
*Schematic::FeaturesApi* | [**count_companies_audience**](docs/FeaturesApi.md#count_companies_audience) | **POST** /audience/count-companies | Count Companies audience
*Schematic::FeaturesApi* | [**count_flag_checks**](docs/FeaturesApi.md#count_flag_checks) | **GET** /flag-checks/count | Count flag checks
*Schematic::FeaturesApi* | [**count_users_audience**](docs/FeaturesApi.md#count_users_audience) | **POST** /audience/count-users | Count Users audience
*Schematic::FeaturesApi* | [**create_feature**](docs/FeaturesApi.md#create_feature) | **POST** /features | Create feature
*Schematic::FeaturesApi* | [**create_flag**](docs/FeaturesApi.md#create_flag) | **POST** /flags | Create flag
*Schematic::FeaturesApi* | [**create_rule**](docs/FeaturesApi.md#create_rule) | **POST** /rules | Create rule
*Schematic::FeaturesApi* | [**delete_feature**](docs/FeaturesApi.md#delete_feature) | **DELETE** /features/{feature_id} | Delete feature
*Schematic::FeaturesApi* | [**delete_flag**](docs/FeaturesApi.md#delete_flag) | **DELETE** /flags/{flag_id} | Delete flag
*Schematic::FeaturesApi* | [**get_companies_audience**](docs/FeaturesApi.md#get_companies_audience) | **POST** /audience/get-companies | Get Companies audience
*Schematic::FeaturesApi* | [**get_feature**](docs/FeaturesApi.md#get_feature) | **GET** /features/{feature_id} | Get feature
*Schematic::FeaturesApi* | [**get_flag**](docs/FeaturesApi.md#get_flag) | **GET** /flags/{flag_id} | Get flag
*Schematic::FeaturesApi* | [**get_flag_check**](docs/FeaturesApi.md#get_flag_check) | **GET** /flag-checks/{flag_check_id} | Get flag check
*Schematic::FeaturesApi* | [**get_rule**](docs/FeaturesApi.md#get_rule) | **GET** /rules/{rule_id} | Get rule
*Schematic::FeaturesApi* | [**get_users_audience**](docs/FeaturesApi.md#get_users_audience) | **POST** /audience/get-users | Get Users audience
*Schematic::FeaturesApi* | [**latest_flag_checks**](docs/FeaturesApi.md#latest_flag_checks) | **GET** /flag-checks/latest | Latest flag checks
*Schematic::FeaturesApi* | [**list_features**](docs/FeaturesApi.md#list_features) | **GET** /features | List features
*Schematic::FeaturesApi* | [**list_flag_checks**](docs/FeaturesApi.md#list_flag_checks) | **GET** /flag-checks | List flag checks
*Schematic::FeaturesApi* | [**list_flags**](docs/FeaturesApi.md#list_flags) | **GET** /flags | List flags
*Schematic::FeaturesApi* | [**update_feature**](docs/FeaturesApi.md#update_feature) | **PUT** /features/{feature_id} | Update feature
*Schematic::FeaturesApi* | [**update_flag**](docs/FeaturesApi.md#update_flag) | **PUT** /flags/{flag_id} | Update flag
*Schematic::FeaturesApi* | [**update_rule**](docs/FeaturesApi.md#update_rule) | **PUT** /rules/{rule_id} | Update rule
*Schematic::PlansApi* | [**create_plan**](docs/PlansApi.md#create_plan) | **POST** /plans | Create plan
*Schematic::PlansApi* | [**delete_plan**](docs/PlansApi.md#delete_plan) | **DELETE** /plans/{plan_id} | Delete plan
*Schematic::PlansApi* | [**get_plan**](docs/PlansApi.md#get_plan) | **GET** /plans/{plan_id} | Get plan
*Schematic::PlansApi* | [**list_plans**](docs/PlansApi.md#list_plans) | **GET** /plans | List plans
*Schematic::PlansApi* | [**update_plan**](docs/PlansApi.md#update_plan) | **PUT** /plans/{plan_id} | Update plan
*Schematic::PlansApi* | [**update_plan_audience**](docs/PlansApi.md#update_plan_audience) | **PUT** /plan-audiences/{plan_audience_id} | Update plan audience
*Schematic::PlansApi* | [**upsert_billing_period**](docs/PlansApi.md#upsert_billing_period) | **POST** /billing-periods/{key}/upsert | Upsert billing period


## Documentation for Models

 - [Schematic::ApiError](docs/ApiError.md)
 - [Schematic::ApiKeyCreateResponseData](docs/ApiKeyCreateResponseData.md)
 - [Schematic::ApiKeyRequestListResponseData](docs/ApiKeyRequestListResponseData.md)
 - [Schematic::ApiKeyRequestResponseData](docs/ApiKeyRequestResponseData.md)
 - [Schematic::ApiKeyResponseData](docs/ApiKeyResponseData.md)
 - [Schematic::AudienceRequestBody](docs/AudienceRequestBody.md)
 - [Schematic::BillingPeriodResponseData](docs/BillingPeriodResponseData.md)
 - [Schematic::CheckFlagOutputWithFlagKey](docs/CheckFlagOutputWithFlagKey.md)
 - [Schematic::CheckFlagRequestBody](docs/CheckFlagRequestBody.md)
 - [Schematic::CheckFlagResponse](docs/CheckFlagResponse.md)
 - [Schematic::CheckFlagResponseData](docs/CheckFlagResponseData.md)
 - [Schematic::CheckFlagsResponse](docs/CheckFlagsResponse.md)
 - [Schematic::CheckFlagsResponseData](docs/CheckFlagsResponseData.md)
 - [Schematic::CompanyDetailResponseData](docs/CompanyDetailResponseData.md)
 - [Schematic::CompanyMembershipDetailResponseData](docs/CompanyMembershipDetailResponseData.md)
 - [Schematic::CompanyMembershipResponseData](docs/CompanyMembershipResponseData.md)
 - [Schematic::CompanyPlanResponseData](docs/CompanyPlanResponseData.md)
 - [Schematic::CompanyResponseData](docs/CompanyResponseData.md)
 - [Schematic::CountApiKeysParams](docs/CountApiKeysParams.md)
 - [Schematic::CountApiKeysResponse](docs/CountApiKeysResponse.md)
 - [Schematic::CountApiRequestsParams](docs/CountApiRequestsParams.md)
 - [Schematic::CountApiRequestsResponse](docs/CountApiRequestsResponse.md)
 - [Schematic::CountCompaniesAudienceResponse](docs/CountCompaniesAudienceResponse.md)
 - [Schematic::CountEventTypesParams](docs/CountEventTypesParams.md)
 - [Schematic::CountEventTypesResponse](docs/CountEventTypesResponse.md)
 - [Schematic::CountEventsParams](docs/CountEventsParams.md)
 - [Schematic::CountEventsResponse](docs/CountEventsResponse.md)
 - [Schematic::CountFlagChecksParams](docs/CountFlagChecksParams.md)
 - [Schematic::CountFlagChecksResponse](docs/CountFlagChecksResponse.md)
 - [Schematic::CountResponse](docs/CountResponse.md)
 - [Schematic::CountUsersAudienceResponse](docs/CountUsersAudienceResponse.md)
 - [Schematic::CreateApiKeyRequestBody](docs/CreateApiKeyRequestBody.md)
 - [Schematic::CreateApiKeyResponse](docs/CreateApiKeyResponse.md)
 - [Schematic::CreateCompanyMembershipResponse](docs/CreateCompanyMembershipResponse.md)
 - [Schematic::CreateCompanyResponse](docs/CreateCompanyResponse.md)
 - [Schematic::CreateEnvironmentRequestBody](docs/CreateEnvironmentRequestBody.md)
 - [Schematic::CreateEnvironmentResponse](docs/CreateEnvironmentResponse.md)
 - [Schematic::CreateEventRequestBody](docs/CreateEventRequestBody.md)
 - [Schematic::CreateEventResponse](docs/CreateEventResponse.md)
 - [Schematic::CreateFeatureRequestBody](docs/CreateFeatureRequestBody.md)
 - [Schematic::CreateFeatureResponse](docs/CreateFeatureResponse.md)
 - [Schematic::CreateFlagRequestBody](docs/CreateFlagRequestBody.md)
 - [Schematic::CreateFlagResponse](docs/CreateFlagResponse.md)
 - [Schematic::CreateOrUpdateConditionGroupRequestBody](docs/CreateOrUpdateConditionGroupRequestBody.md)
 - [Schematic::CreateOrUpdateConditionRequestBody](docs/CreateOrUpdateConditionRequestBody.md)
 - [Schematic::CreateOrUpdateFlagRequestBody](docs/CreateOrUpdateFlagRequestBody.md)
 - [Schematic::CreateOrUpdateRuleRequestBody](docs/CreateOrUpdateRuleRequestBody.md)
 - [Schematic::CreatePlanRequestBody](docs/CreatePlanRequestBody.md)
 - [Schematic::CreatePlanResponse](docs/CreatePlanResponse.md)
 - [Schematic::CreateRuleRequestBody](docs/CreateRuleRequestBody.md)
 - [Schematic::CreateRuleResponse](docs/CreateRuleResponse.md)
 - [Schematic::CreateUserResponse](docs/CreateUserResponse.md)
 - [Schematic::DeleteApiKeyResponse](docs/DeleteApiKeyResponse.md)
 - [Schematic::DeleteCompanyMembershipResponse](docs/DeleteCompanyMembershipResponse.md)
 - [Schematic::DeleteEnvironmentResponse](docs/DeleteEnvironmentResponse.md)
 - [Schematic::DeleteFeatureResponse](docs/DeleteFeatureResponse.md)
 - [Schematic::DeleteFlagResponse](docs/DeleteFlagResponse.md)
 - [Schematic::DeletePlanResponse](docs/DeletePlanResponse.md)
 - [Schematic::DeleteResponse](docs/DeleteResponse.md)
 - [Schematic::EntityKeyResponseData](docs/EntityKeyResponseData.md)
 - [Schematic::EntityTraitDefinitionResponseData](docs/EntityTraitDefinitionResponseData.md)
 - [Schematic::EnvironmentDetailResponseData](docs/EnvironmentDetailResponseData.md)
 - [Schematic::EnvironmentResponseData](docs/EnvironmentResponseData.md)
 - [Schematic::EventBody](docs/EventBody.md)
 - [Schematic::EventBodyIdentify](docs/EventBodyIdentify.md)
 - [Schematic::EventBodyIdentifyCompany](docs/EventBodyIdentifyCompany.md)
 - [Schematic::EventBodyTrack](docs/EventBodyTrack.md)
 - [Schematic::EventResponseData](docs/EventResponseData.md)
 - [Schematic::EventSummaryResponseData](docs/EventSummaryResponseData.md)
 - [Schematic::FeatureDetailResponseData](docs/FeatureDetailResponseData.md)
 - [Schematic::FeatureResponseData](docs/FeatureResponseData.md)
 - [Schematic::FlagCheckLogDetailResponseData](docs/FlagCheckLogDetailResponseData.md)
 - [Schematic::FlagCheckLogResponseData](docs/FlagCheckLogResponseData.md)
 - [Schematic::FlagDetailResponseData](docs/FlagDetailResponseData.md)
 - [Schematic::FlagResponseData](docs/FlagResponseData.md)
 - [Schematic::GetApiKeyResponse](docs/GetApiKeyResponse.md)
 - [Schematic::GetApiRequestResponse](docs/GetApiRequestResponse.md)
 - [Schematic::GetCompaniesAudienceResponse](docs/GetCompaniesAudienceResponse.md)
 - [Schematic::GetCompanyResponse](docs/GetCompanyResponse.md)
 - [Schematic::GetEnvironmentResponse](docs/GetEnvironmentResponse.md)
 - [Schematic::GetEventResponse](docs/GetEventResponse.md)
 - [Schematic::GetEventTypeResponse](docs/GetEventTypeResponse.md)
 - [Schematic::GetFeatureResponse](docs/GetFeatureResponse.md)
 - [Schematic::GetFlagCheckResponse](docs/GetFlagCheckResponse.md)
 - [Schematic::GetFlagResponse](docs/GetFlagResponse.md)
 - [Schematic::GetOrCreateCompanyMembershipRequestBody](docs/GetOrCreateCompanyMembershipRequestBody.md)
 - [Schematic::GetPlanResponse](docs/GetPlanResponse.md)
 - [Schematic::GetRuleResponse](docs/GetRuleResponse.md)
 - [Schematic::GetUserResponse](docs/GetUserResponse.md)
 - [Schematic::GetUsersAudienceResponse](docs/GetUsersAudienceResponse.md)
 - [Schematic::LatestFlagChecksParams](docs/LatestFlagChecksParams.md)
 - [Schematic::LatestFlagChecksResponse](docs/LatestFlagChecksResponse.md)
 - [Schematic::ListApiKeysParams](docs/ListApiKeysParams.md)
 - [Schematic::ListApiKeysResponse](docs/ListApiKeysResponse.md)
 - [Schematic::ListApiRequestsParams](docs/ListApiRequestsParams.md)
 - [Schematic::ListApiRequestsResponse](docs/ListApiRequestsResponse.md)
 - [Schematic::ListCompaniesParams](docs/ListCompaniesParams.md)
 - [Schematic::ListCompaniesResponse](docs/ListCompaniesResponse.md)
 - [Schematic::ListCompanyMembershipsParams](docs/ListCompanyMembershipsParams.md)
 - [Schematic::ListCompanyMembershipsResponse](docs/ListCompanyMembershipsResponse.md)
 - [Schematic::ListCompanyPlansParams](docs/ListCompanyPlansParams.md)
 - [Schematic::ListCompanyPlansResponse](docs/ListCompanyPlansResponse.md)
 - [Schematic::ListEventTypesParams](docs/ListEventTypesParams.md)
 - [Schematic::ListEventTypesResponse](docs/ListEventTypesResponse.md)
 - [Schematic::ListEventsParams](docs/ListEventsParams.md)
 - [Schematic::ListEventsResponse](docs/ListEventsResponse.md)
 - [Schematic::ListFeaturesParams](docs/ListFeaturesParams.md)
 - [Schematic::ListFeaturesResponse](docs/ListFeaturesResponse.md)
 - [Schematic::ListFlagChecksParams](docs/ListFlagChecksParams.md)
 - [Schematic::ListFlagChecksResponse](docs/ListFlagChecksResponse.md)
 - [Schematic::ListFlagsParams](docs/ListFlagsParams.md)
 - [Schematic::ListFlagsResponse](docs/ListFlagsResponse.md)
 - [Schematic::ListMetricCountsHourlyParams](docs/ListMetricCountsHourlyParams.md)
 - [Schematic::ListMetricCountsHourlyResponse](docs/ListMetricCountsHourlyResponse.md)
 - [Schematic::ListMetricCountsParams](docs/ListMetricCountsParams.md)
 - [Schematic::ListMetricCountsResponse](docs/ListMetricCountsResponse.md)
 - [Schematic::ListPlansParams](docs/ListPlansParams.md)
 - [Schematic::ListPlansResponse](docs/ListPlansResponse.md)
 - [Schematic::ListUsersParams](docs/ListUsersParams.md)
 - [Schematic::ListUsersResponse](docs/ListUsersResponse.md)
 - [Schematic::MetricCountsHourlyResponseData](docs/MetricCountsHourlyResponseData.md)
 - [Schematic::PaginationFilter](docs/PaginationFilter.md)
 - [Schematic::PlanResponseData](docs/PlanResponseData.md)
 - [Schematic::RuleConditionGroupDetailResponseData](docs/RuleConditionGroupDetailResponseData.md)
 - [Schematic::RuleConditionGroupResponseData](docs/RuleConditionGroupResponseData.md)
 - [Schematic::RuleConditionResponseData](docs/RuleConditionResponseData.md)
 - [Schematic::RuleDetailResponseData](docs/RuleDetailResponseData.md)
 - [Schematic::RuleResponseData](docs/RuleResponseData.md)
 - [Schematic::UpdateApiKeyRequestBody](docs/UpdateApiKeyRequestBody.md)
 - [Schematic::UpdateApiKeyResponse](docs/UpdateApiKeyResponse.md)
 - [Schematic::UpdateAudienceRequestBody](docs/UpdateAudienceRequestBody.md)
 - [Schematic::UpdateEntityTraitDefinitionRequestBody](docs/UpdateEntityTraitDefinitionRequestBody.md)
 - [Schematic::UpdateEntityTraitDefinitionResponse](docs/UpdateEntityTraitDefinitionResponse.md)
 - [Schematic::UpdateEnvironmentRequestBody](docs/UpdateEnvironmentRequestBody.md)
 - [Schematic::UpdateEnvironmentResponse](docs/UpdateEnvironmentResponse.md)
 - [Schematic::UpdateFeatureRequestBody](docs/UpdateFeatureRequestBody.md)
 - [Schematic::UpdateFeatureResponse](docs/UpdateFeatureResponse.md)
 - [Schematic::UpdateFlagResponse](docs/UpdateFlagResponse.md)
 - [Schematic::UpdatePlanAudienceResponse](docs/UpdatePlanAudienceResponse.md)
 - [Schematic::UpdatePlanRequestBody](docs/UpdatePlanRequestBody.md)
 - [Schematic::UpdatePlanResponse](docs/UpdatePlanResponse.md)
 - [Schematic::UpdateRuleRequestBody](docs/UpdateRuleRequestBody.md)
 - [Schematic::UpdateRuleResponse](docs/UpdateRuleResponse.md)
 - [Schematic::UpsertBillingPeriodRequestBody](docs/UpsertBillingPeriodRequestBody.md)
 - [Schematic::UpsertBillingPeriodResponse](docs/UpsertBillingPeriodResponse.md)
 - [Schematic::UpsertCompanyRequestBody](docs/UpsertCompanyRequestBody.md)
 - [Schematic::UpsertUserRequestBody](docs/UpsertUserRequestBody.md)
 - [Schematic::UpsertUserSubRequestBody](docs/UpsertUserSubRequestBody.md)
 - [Schematic::UserDetailResponseData](docs/UserDetailResponseData.md)
 - [Schematic::UserResponseData](docs/UserResponseData.md)


## Documentation for Authorization


Authentication schemes defined for the API:
### ApiKeyAuth


- **Type**: API key
- **API key parameter name**: X-Schematic-Api-Key
- **Location**: HTTP header

