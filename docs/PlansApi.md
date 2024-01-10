# Schematic::PlansApi

All URIs are relative to *https://api.schematichq.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_plan**](PlansApi.md#create_plan) | **POST** /plans | Create plan |
| [**delete_plan**](PlansApi.md#delete_plan) | **DELETE** /plans/{plan_id} | Delete plan |
| [**get_plan**](PlansApi.md#get_plan) | **GET** /plans/{plan_id} | Get plan |
| [**list_plans**](PlansApi.md#list_plans) | **GET** /plans | List plans |
| [**update_plan**](PlansApi.md#update_plan) | **PUT** /plans/{plan_id} | Update plan |
| [**update_plan_audience**](PlansApi.md#update_plan_audience) | **PUT** /plan-audiences/{plan_audience_id} | Update plan audience |
| [**upsert_billing_period**](PlansApi.md#upsert_billing_period) | **POST** /billing-periods/{key}/upsert | Upsert billing period |


## create_plan

> <CreatePlanResponse> create_plan(create_plan_request_body, opts)

Create plan

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

api_instance = Schematic::PlansApi.new
create_plan_request_body = Schematic::CreatePlanRequestBody.new({name: 'name_example'}) # CreatePlanRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create plan
  result = api_instance.create_plan(create_plan_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->create_plan: #{e}"
end
```

#### Using the create_plan_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreatePlanResponse>, Integer, Hash)> create_plan_with_http_info(create_plan_request_body, opts)

```ruby
begin
  # Create plan
  data, status_code, headers = api_instance.create_plan_with_http_info(create_plan_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreatePlanResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->create_plan_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_plan_request_body** | [**CreatePlanRequestBody**](CreatePlanRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreatePlanResponse**](CreatePlanResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_plan

> <DeletePlanResponse> delete_plan(plan_id, opts)

Delete plan

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

api_instance = Schematic::PlansApi.new
plan_id = 'plan_id_example' # String | plan_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete plan
  result = api_instance.delete_plan(plan_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->delete_plan: #{e}"
end
```

#### Using the delete_plan_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeletePlanResponse>, Integer, Hash)> delete_plan_with_http_info(plan_id, opts)

```ruby
begin
  # Delete plan
  data, status_code, headers = api_instance.delete_plan_with_http_info(plan_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeletePlanResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->delete_plan_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **plan_id** | **String** | plan_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeletePlanResponse**](DeletePlanResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_plan

> <GetPlanResponse> get_plan(plan_id, opts)

Get plan

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

api_instance = Schematic::PlansApi.new
plan_id = 'plan_id_example' # String | plan_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get plan
  result = api_instance.get_plan(plan_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->get_plan: #{e}"
end
```

#### Using the get_plan_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetPlanResponse>, Integer, Hash)> get_plan_with_http_info(plan_id, opts)

```ruby
begin
  # Get plan
  data, status_code, headers = api_instance.get_plan_with_http_info(plan_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetPlanResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->get_plan_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **plan_id** | **String** | plan_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetPlanResponse**](GetPlanResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_plans

> <ListPlansResponse> list_plans(opts)

List plans

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

api_instance = Schematic::PlansApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  limit: 56, # Integer | Page limit (default 100)
  offset: 56 # Integer | Page offset (default 0)
}

begin
  # List plans
  result = api_instance.list_plans(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->list_plans: #{e}"
end
```

#### Using the list_plans_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListPlansResponse>, Integer, Hash)> list_plans_with_http_info(opts)

```ruby
begin
  # List plans
  data, status_code, headers = api_instance.list_plans_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListPlansResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->list_plans_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |

### Return type

[**ListPlansResponse**](ListPlansResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_plan

> <UpdatePlanResponse> update_plan(plan_id, update_plan_request_body, opts)

Update plan

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

api_instance = Schematic::PlansApi.new
plan_id = 'plan_id_example' # String | plan_id
update_plan_request_body = Schematic::UpdatePlanRequestBody.new({name: 'name_example'}) # UpdatePlanRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update plan
  result = api_instance.update_plan(plan_id, update_plan_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->update_plan: #{e}"
end
```

#### Using the update_plan_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdatePlanResponse>, Integer, Hash)> update_plan_with_http_info(plan_id, update_plan_request_body, opts)

```ruby
begin
  # Update plan
  data, status_code, headers = api_instance.update_plan_with_http_info(plan_id, update_plan_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdatePlanResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->update_plan_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **plan_id** | **String** | plan_id |  |
| **update_plan_request_body** | [**UpdatePlanRequestBody**](UpdatePlanRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdatePlanResponse**](UpdatePlanResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## update_plan_audience

> <UpdatePlanAudienceResponse> update_plan_audience(plan_audience_id, update_audience_request_body, opts)

Update plan audience

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

api_instance = Schematic::PlansApi.new
plan_audience_id = 'plan_audience_id_example' # String | plan_audience_id
update_audience_request_body = Schematic::UpdateAudienceRequestBody.new({condition_groups: [Schematic::CreateOrUpdateConditionGroupRequestBody.new({conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]})], conditions: [Schematic::CreateOrUpdateConditionRequestBody.new({condition_type: 'condition_type_example', metric_value: 37, operator: 'operator_example', resource_ids: ['resource_ids_example']})]}) # UpdateAudienceRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update plan audience
  result = api_instance.update_plan_audience(plan_audience_id, update_audience_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->update_plan_audience: #{e}"
end
```

#### Using the update_plan_audience_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdatePlanAudienceResponse>, Integer, Hash)> update_plan_audience_with_http_info(plan_audience_id, update_audience_request_body, opts)

```ruby
begin
  # Update plan audience
  data, status_code, headers = api_instance.update_plan_audience_with_http_info(plan_audience_id, update_audience_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdatePlanAudienceResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->update_plan_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **plan_audience_id** | **String** | plan_audience_id |  |
| **update_audience_request_body** | [**UpdateAudienceRequestBody**](UpdateAudienceRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdatePlanAudienceResponse**](UpdatePlanAudienceResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## upsert_billing_period

> <UpsertBillingPeriodResponse> upsert_billing_period(key, upsert_billing_period_request_body, opts)

Upsert billing period

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

api_instance = Schematic::PlansApi.new
key = 'key_example' # String | key
upsert_billing_period_request_body = Schematic::UpsertBillingPeriodRequestBody.new({company_id: 'company_id_example', started_at: Time.now}) # UpsertBillingPeriodRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Upsert billing period
  result = api_instance.upsert_billing_period(key, upsert_billing_period_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->upsert_billing_period: #{e}"
end
```

#### Using the upsert_billing_period_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpsertBillingPeriodResponse>, Integer, Hash)> upsert_billing_period_with_http_info(key, upsert_billing_period_request_body, opts)

```ruby
begin
  # Upsert billing period
  data, status_code, headers = api_instance.upsert_billing_period_with_http_info(key, upsert_billing_period_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpsertBillingPeriodResponse>
rescue Schematic::ApiError => e
  puts "Error when calling PlansApi->upsert_billing_period_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **key** | **String** | key |  |
| **upsert_billing_period_request_body** | [**UpsertBillingPeriodRequestBody**](UpsertBillingPeriodRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpsertBillingPeriodResponse**](UpsertBillingPeriodResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

