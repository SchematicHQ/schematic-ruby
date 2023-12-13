# Schematic::FeaturesApi

All URIs are relative to *https://api.schematichq.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**check_flag**](FeaturesApi.md#check_flag) | **POST** /flags/{key}/check | Check flag |
| [**check_flags**](FeaturesApi.md#check_flags) | **POST** /flags/check | Check flags |
| [**count_companies_audience**](FeaturesApi.md#count_companies_audience) | **POST** /audience/count-companies | Count Companies audience |
| [**count_flag_values**](FeaturesApi.md#count_flag_values) | **GET** /flag-values/count | Count flag values |
| [**count_users_audience**](FeaturesApi.md#count_users_audience) | **POST** /audience/count-users | Count Users audience |
| [**create_feature**](FeaturesApi.md#create_feature) | **POST** /features | Create feature |
| [**create_flag**](FeaturesApi.md#create_flag) | **POST** /flags | Create flag |
| [**create_rule**](FeaturesApi.md#create_rule) | **POST** /rules | Create rule |
| [**delete_feature**](FeaturesApi.md#delete_feature) | **DELETE** /features/{feature_id} | Delete feature |
| [**delete_flag**](FeaturesApi.md#delete_flag) | **DELETE** /flags/{flag_id} | Delete flag |
| [**get_companies_audience**](FeaturesApi.md#get_companies_audience) | **POST** /audience/get-companies | Get Companies audience |
| [**get_feature**](FeaturesApi.md#get_feature) | **GET** /features/{feature_id} | Get feature |
| [**get_flag**](FeaturesApi.md#get_flag) | **GET** /flags/{flag_id} | Get flag |
| [**get_rule**](FeaturesApi.md#get_rule) | **GET** /rules/{rule_id} | Get rule |
| [**get_users_audience**](FeaturesApi.md#get_users_audience) | **POST** /audience/get-users | Get Users audience |
| [**latest_flag_checks**](FeaturesApi.md#latest_flag_checks) | **GET** /flag-checks/latest | Latest flag checks |
| [**list_features**](FeaturesApi.md#list_features) | **GET** /features | List features |
| [**list_flag_checks**](FeaturesApi.md#list_flag_checks) | **GET** /flag-checks | List flag checks |
| [**list_flag_values**](FeaturesApi.md#list_flag_values) | **GET** /flag-values | List flag values |
| [**list_flags**](FeaturesApi.md#list_flags) | **GET** /flags | List flags |
| [**update_feature**](FeaturesApi.md#update_feature) | **PUT** /features/{feature_id} | Update feature |
| [**update_flag**](FeaturesApi.md#update_flag) | **PUT** /flags/{flag_id} | Update flag |
| [**update_rule**](FeaturesApi.md#update_rule) | **PUT** /rules/{rule_id} | Update rule |


## check_flag

> <CheckFlagResponse> check_flag(key, check_flag_request_body, opts)

Check flag

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
key = 'key_example' # String | key
check_flag_request_body = Schematic::CheckFlagRequestBody.new({company: 3.56}) # CheckFlagRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Check flag
  result = api_instance.check_flag(key, check_flag_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->check_flag: #{e}"
end
```

#### Using the check_flag_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CheckFlagResponse>, Integer, Hash)> check_flag_with_http_info(key, check_flag_request_body, opts)

```ruby
begin
  # Check flag
  data, status_code, headers = api_instance.check_flag_with_http_info(key, check_flag_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CheckFlagResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->check_flag_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **key** | **String** | key |  |
| **check_flag_request_body** | [**CheckFlagRequestBody**](CheckFlagRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CheckFlagResponse**](CheckFlagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## check_flags

> <CheckFlagsResponse> check_flags(check_flag_request_body, opts)

Check flags

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
check_flag_request_body = Schematic::CheckFlagRequestBody.new({company: 3.56}) # CheckFlagRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Check flags
  result = api_instance.check_flags(check_flag_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->check_flags: #{e}"
end
```

#### Using the check_flags_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CheckFlagsResponse>, Integer, Hash)> check_flags_with_http_info(check_flag_request_body, opts)

```ruby
begin
  # Check flags
  data, status_code, headers = api_instance.check_flags_with_http_info(check_flag_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CheckFlagsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->check_flags_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **check_flag_request_body** | [**CheckFlagRequestBody**](CheckFlagRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CheckFlagsResponse**](CheckFlagsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## count_companies_audience

> <CountCompaniesAudienceResponse> count_companies_audience(audience_request_body, opts)

Count Companies audience

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
audience_request_body = Schematic::AudienceRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]}) # AudienceRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Count Companies audience
  result = api_instance.count_companies_audience(audience_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_companies_audience: #{e}"
end
```

#### Using the count_companies_audience_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountCompaniesAudienceResponse>, Integer, Hash)> count_companies_audience_with_http_info(audience_request_body, opts)

```ruby
begin
  # Count Companies audience
  data, status_code, headers = api_instance.count_companies_audience_with_http_info(audience_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountCompaniesAudienceResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_companies_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_request_body** | [**AudienceRequestBody**](AudienceRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CountCompaniesAudienceResponse**](CountCompaniesAudienceResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## count_flag_values

> <CountFlagValuesResponse> count_flag_values(entity_type, opts)

Count flag values

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
entity_type = 56 # Integer | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  flag_id: 'flag_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # Count flag values
  result = api_instance.count_flag_values(entity_type, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_flag_values: #{e}"
end
```

#### Using the count_flag_values_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountFlagValuesResponse>, Integer, Hash)> count_flag_values_with_http_info(entity_type, opts)

```ruby
begin
  # Count flag values
  data, status_code, headers = api_instance.count_flag_values_with_http_info(entity_type, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountFlagValuesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_flag_values_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **entity_type** | **Integer** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **flag_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**CountFlagValuesResponse**](CountFlagValuesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## count_users_audience

> <CountUsersAudienceResponse> count_users_audience(audience_request_body, opts)

Count Users audience

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
audience_request_body = Schematic::AudienceRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]}) # AudienceRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Count Users audience
  result = api_instance.count_users_audience(audience_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_users_audience: #{e}"
end
```

#### Using the count_users_audience_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountUsersAudienceResponse>, Integer, Hash)> count_users_audience_with_http_info(audience_request_body, opts)

```ruby
begin
  # Count Users audience
  data, status_code, headers = api_instance.count_users_audience_with_http_info(audience_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountUsersAudienceResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->count_users_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_request_body** | [**AudienceRequestBody**](AudienceRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CountUsersAudienceResponse**](CountUsersAudienceResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_feature

> <CreateFeatureResponse> create_feature(create_feature_request_body, opts)

Create feature

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
create_feature_request_body = Schematic::CreateFeatureRequestBody.new({description: 'description_example', feature_type: 'feature_type_example', name: 'name_example'}) # CreateFeatureRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create feature
  result = api_instance.create_feature(create_feature_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_feature: #{e}"
end
```

#### Using the create_feature_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateFeatureResponse>, Integer, Hash)> create_feature_with_http_info(create_feature_request_body, opts)

```ruby
begin
  # Create feature
  data, status_code, headers = api_instance.create_feature_with_http_info(create_feature_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateFeatureResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_feature_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_feature_request_body** | [**CreateFeatureRequestBody**](CreateFeatureRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateFeatureResponse**](CreateFeatureResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_flag

> <CreateFlagResponse> create_flag(create_flag_request_body, opts)

Create flag

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
create_flag_request_body = Schematic::CreateFlagRequestBody.new({default_value: false, description: 'description_example', flag_type: 'flag_type_example', key: 'key_example', name: 'name_example', rules: [Schematic::CreateOrUpdateRuleRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})], name: 'name_example', priority: 37, value: false})]}) # CreateFlagRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create flag
  result = api_instance.create_flag(create_flag_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_flag: #{e}"
end
```

#### Using the create_flag_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateFlagResponse>, Integer, Hash)> create_flag_with_http_info(create_flag_request_body, opts)

```ruby
begin
  # Create flag
  data, status_code, headers = api_instance.create_flag_with_http_info(create_flag_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateFlagResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_flag_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_flag_request_body** | [**CreateFlagRequestBody**](CreateFlagRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateFlagResponse**](CreateFlagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_rule

> <CreateRuleResponse> create_rule(create_rule_request_body, opts)

Create rule

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
create_rule_request_body = Schematic::CreateRuleRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})], name: 'name_example', priority: 37, value: false}) # CreateRuleRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create rule
  result = api_instance.create_rule(create_rule_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_rule: #{e}"
end
```

#### Using the create_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateRuleResponse>, Integer, Hash)> create_rule_with_http_info(create_rule_request_body, opts)

```ruby
begin
  # Create rule
  data, status_code, headers = api_instance.create_rule_with_http_info(create_rule_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateRuleResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->create_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_rule_request_body** | [**CreateRuleRequestBody**](CreateRuleRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateRuleResponse**](CreateRuleResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_feature

> <DeleteFeatureResponse> delete_feature(feature_id, opts)

Delete feature

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
feature_id = 'feature_id_example' # String | feature_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete feature
  result = api_instance.delete_feature(feature_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->delete_feature: #{e}"
end
```

#### Using the delete_feature_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteFeatureResponse>, Integer, Hash)> delete_feature_with_http_info(feature_id, opts)

```ruby
begin
  # Delete feature
  data, status_code, headers = api_instance.delete_feature_with_http_info(feature_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteFeatureResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->delete_feature_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **feature_id** | **String** | feature_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeleteFeatureResponse**](DeleteFeatureResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## delete_flag

> <DeleteFlagResponse> delete_flag(flag_id, opts)

Delete flag

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
flag_id = 'flag_id_example' # String | flag_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete flag
  result = api_instance.delete_flag(flag_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->delete_flag: #{e}"
end
```

#### Using the delete_flag_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteFlagResponse>, Integer, Hash)> delete_flag_with_http_info(flag_id, opts)

```ruby
begin
  # Delete flag
  data, status_code, headers = api_instance.delete_flag_with_http_info(flag_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteFlagResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->delete_flag_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **flag_id** | **String** | flag_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeleteFlagResponse**](DeleteFlagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_companies_audience

> <GetCompaniesAudienceResponse> get_companies_audience(audience_request_body, opts)

Get Companies audience

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
audience_request_body = Schematic::AudienceRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]}) # AudienceRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get Companies audience
  result = api_instance.get_companies_audience(audience_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_companies_audience: #{e}"
end
```

#### Using the get_companies_audience_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetCompaniesAudienceResponse>, Integer, Hash)> get_companies_audience_with_http_info(audience_request_body, opts)

```ruby
begin
  # Get Companies audience
  data, status_code, headers = api_instance.get_companies_audience_with_http_info(audience_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetCompaniesAudienceResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_companies_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_request_body** | [**AudienceRequestBody**](AudienceRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetCompaniesAudienceResponse**](GetCompaniesAudienceResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## get_feature

> <GetFeatureResponse> get_feature(feature_id, opts)

Get feature

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
feature_id = 'feature_id_example' # String | feature_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get feature
  result = api_instance.get_feature(feature_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_feature: #{e}"
end
```

#### Using the get_feature_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetFeatureResponse>, Integer, Hash)> get_feature_with_http_info(feature_id, opts)

```ruby
begin
  # Get feature
  data, status_code, headers = api_instance.get_feature_with_http_info(feature_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetFeatureResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_feature_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **feature_id** | **String** | feature_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetFeatureResponse**](GetFeatureResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_flag

> <GetFlagResponse> get_flag(flag_id, opts)

Get flag

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
flag_id = 'flag_id_example' # String | flag_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get flag
  result = api_instance.get_flag(flag_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_flag: #{e}"
end
```

#### Using the get_flag_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetFlagResponse>, Integer, Hash)> get_flag_with_http_info(flag_id, opts)

```ruby
begin
  # Get flag
  data, status_code, headers = api_instance.get_flag_with_http_info(flag_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetFlagResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_flag_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **flag_id** | **String** | flag_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetFlagResponse**](GetFlagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rule

> <GetRuleResponse> get_rule(rule_id, opts)

Get rule

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
rule_id = 'rule_id_example' # String | rule_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get rule
  result = api_instance.get_rule(rule_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_rule: #{e}"
end
```

#### Using the get_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetRuleResponse>, Integer, Hash)> get_rule_with_http_info(rule_id, opts)

```ruby
begin
  # Get rule
  data, status_code, headers = api_instance.get_rule_with_http_info(rule_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetRuleResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rule_id** | **String** | rule_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetRuleResponse**](GetRuleResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_users_audience

> <GetUsersAudienceResponse> get_users_audience(audience_request_body, opts)

Get Users audience

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
audience_request_body = Schematic::AudienceRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]}) # AudienceRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get Users audience
  result = api_instance.get_users_audience(audience_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_users_audience: #{e}"
end
```

#### Using the get_users_audience_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetUsersAudienceResponse>, Integer, Hash)> get_users_audience_with_http_info(audience_request_body, opts)

```ruby
begin
  # Get Users audience
  data, status_code, headers = api_instance.get_users_audience_with_http_info(audience_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetUsersAudienceResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->get_users_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_request_body** | [**AudienceRequestBody**](AudienceRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetUsersAudienceResponse**](GetUsersAudienceResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## latest_flag_checks

> <LatestFlagChecksResponse> latest_flag_checks(opts)

Latest flag checks

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  flag_id: 'flag_id_example', # String | 
  flag_ids: ['inner_example'], # Array<String> | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # Latest flag checks
  result = api_instance.latest_flag_checks(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->latest_flag_checks: #{e}"
end
```

#### Using the latest_flag_checks_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<LatestFlagChecksResponse>, Integer, Hash)> latest_flag_checks_with_http_info(opts)

```ruby
begin
  # Latest flag checks
  data, status_code, headers = api_instance.latest_flag_checks_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <LatestFlagChecksResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->latest_flag_checks_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **flag_id** | **String** |  | [optional] |
| **flag_ids** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**LatestFlagChecksResponse**](LatestFlagChecksResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_features

> <ListFeaturesResponse> list_features(opts)

List features

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List features
  result = api_instance.list_features(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_features: #{e}"
end
```

#### Using the list_features_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListFeaturesResponse>, Integer, Hash)> list_features_with_http_info(opts)

```ruby
begin
  # List features
  data, status_code, headers = api_instance.list_features_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListFeaturesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_features_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListFeaturesResponse**](ListFeaturesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_flag_checks

> <ListFlagChecksResponse> list_flag_checks(opts)

List flag checks

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  flag_id: 'flag_id_example', # String | 
  flag_ids: ['inner_example'], # Array<String> | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List flag checks
  result = api_instance.list_flag_checks(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flag_checks: #{e}"
end
```

#### Using the list_flag_checks_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListFlagChecksResponse>, Integer, Hash)> list_flag_checks_with_http_info(opts)

```ruby
begin
  # List flag checks
  data, status_code, headers = api_instance.list_flag_checks_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListFlagChecksResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flag_checks_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **flag_id** | **String** |  | [optional] |
| **flag_ids** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListFlagChecksResponse**](ListFlagChecksResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_flag_values

> <ListFlagValuesResponse> list_flag_values(entity_type, opts)

List flag values

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
entity_type = 56 # Integer | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  flag_id: 'flag_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List flag values
  result = api_instance.list_flag_values(entity_type, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flag_values: #{e}"
end
```

#### Using the list_flag_values_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListFlagValuesResponse>, Integer, Hash)> list_flag_values_with_http_info(entity_type, opts)

```ruby
begin
  # List flag values
  data, status_code, headers = api_instance.list_flag_values_with_http_info(entity_type, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListFlagValuesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flag_values_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **entity_type** | **Integer** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **flag_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListFlagValuesResponse**](ListFlagValuesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_flags

> <ListFlagsResponse> list_flags(opts)

List flags

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  feature_id: 'feature_id_example', # String | 
  flag_ids: ['inner_example'], # Array<String> | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List flags
  result = api_instance.list_flags(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flags: #{e}"
end
```

#### Using the list_flags_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListFlagsResponse>, Integer, Hash)> list_flags_with_http_info(opts)

```ruby
begin
  # List flags
  data, status_code, headers = api_instance.list_flags_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListFlagsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->list_flags_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **feature_id** | **String** |  | [optional] |
| **flag_ids** | [**Array&lt;String&gt;**](String.md) |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListFlagsResponse**](ListFlagsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_feature

> <UpdateFeatureResponse> update_feature(feature_id, update_feature_request_body, opts)

Update feature

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
feature_id = 'feature_id_example' # String | feature_id
update_feature_request_body = Schematic::UpdateFeatureRequestBody.new # UpdateFeatureRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update feature
  result = api_instance.update_feature(feature_id, update_feature_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_feature: #{e}"
end
```

#### Using the update_feature_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdateFeatureResponse>, Integer, Hash)> update_feature_with_http_info(feature_id, update_feature_request_body, opts)

```ruby
begin
  # Update feature
  data, status_code, headers = api_instance.update_feature_with_http_info(feature_id, update_feature_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdateFeatureResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_feature_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **feature_id** | **String** | feature_id |  |
| **update_feature_request_body** | [**UpdateFeatureRequestBody**](UpdateFeatureRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdateFeatureResponse**](UpdateFeatureResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## update_flag

> <UpdateFlagResponse> update_flag(flag_id, create_flag_request_body, opts)

Update flag

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
flag_id = 'flag_id_example' # String | flag_id
create_flag_request_body = Schematic::CreateFlagRequestBody.new({default_value: false, description: 'description_example', flag_type: 'flag_type_example', key: 'key_example', name: 'name_example', rules: [Schematic::CreateOrUpdateRuleRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})], name: 'name_example', priority: 37, value: false})]}) # CreateFlagRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update flag
  result = api_instance.update_flag(flag_id, create_flag_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_flag: #{e}"
end
```

#### Using the update_flag_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdateFlagResponse>, Integer, Hash)> update_flag_with_http_info(flag_id, create_flag_request_body, opts)

```ruby
begin
  # Update flag
  data, status_code, headers = api_instance.update_flag_with_http_info(flag_id, create_flag_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdateFlagResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_flag_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **flag_id** | **String** | flag_id |  |
| **create_flag_request_body** | [**CreateFlagRequestBody**](CreateFlagRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdateFlagResponse**](UpdateFlagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## update_rule

> <UpdateRuleResponse> update_rule(rule_id, update_rule_request_body, opts)

Update rule

### Examples

```ruby
require 'time'
require 'schematic'
# setup authorization
Schematic.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['ApiKeyAuth'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  # config.api_key_prefix['ApiKeyAuth'] = 'Bearer'
end

api_instance = Schematic::FeaturesApi.new
rule_id = 'rule_id_example' # String | rule_id
update_rule_request_body = Schematic::UpdateRuleRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})], name: 'name_example', priority: 37, value: false}) # UpdateRuleRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update rule
  result = api_instance.update_rule(rule_id, update_rule_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_rule: #{e}"
end
```

#### Using the update_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdateRuleResponse>, Integer, Hash)> update_rule_with_http_info(rule_id, update_rule_request_body, opts)

```ruby
begin
  # Update rule
  data, status_code, headers = api_instance.update_rule_with_http_info(rule_id, update_rule_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdateRuleResponse>
rescue Schematic::ApiError => e
  puts "Error when calling FeaturesApi->update_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rule_id** | **String** | rule_id |  |
| **update_rule_request_body** | [**UpdateRuleRequestBody**](UpdateRuleRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdateRuleResponse**](UpdateRuleResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

