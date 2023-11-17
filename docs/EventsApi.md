# Schematic::EventsApi

All URIs are relative to *https://api.schematichq.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**count_event_types**](EventsApi.md#count_event_types) | **GET** /event-types/count | Count event types |
| [**count_events**](EventsApi.md#count_events) | **GET** /events/count | Count events |
| [**create_event**](EventsApi.md#create_event) | **POST** /events | Create event |
| [**get_event**](EventsApi.md#get_event) | **GET** /events/{event_id} | Get event |
| [**get_event_type**](EventsApi.md#get_event_type) | **GET** /event-types/{key} | Get event type |
| [**list_event_types**](EventsApi.md#list_event_types) | **GET** /event-types | List event types |
| [**list_events**](EventsApi.md#list_events) | **GET** /events | List events |
| [**list_metric_counts**](EventsApi.md#list_metric_counts) | **GET** /metric-counts | List metric counts |
| [**list_metric_counts_hourly**](EventsApi.md#list_metric_counts_hourly) | **GET** /metric-counts-hourly | List metric counts hourly |


## count_event_types

> <CountEventTypesResponse> count_event_types(opts)

Count event types

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

api_instance = Schematic::EventsApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  q: 'q_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # Count event types
  result = api_instance.count_event_types(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->count_event_types: #{e}"
end
```

#### Using the count_event_types_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountEventTypesResponse>, Integer, Hash)> count_event_types_with_http_info(opts)

```ruby
begin
  # Count event types
  data, status_code, headers = api_instance.count_event_types_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountEventTypesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->count_event_types_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **q** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**CountEventTypesResponse**](CountEventTypesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## count_events

> <CountEventsResponse> count_events(opts)

Count events

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

api_instance = Schematic::EventsApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  feature_id: 'feature_id_example', # String | 
  event_subtype: 'event_subtype_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # Count events
  result = api_instance.count_events(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->count_events: #{e}"
end
```

#### Using the count_events_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountEventsResponse>, Integer, Hash)> count_events_with_http_info(opts)

```ruby
begin
  # Count events
  data, status_code, headers = api_instance.count_events_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountEventsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->count_events_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **feature_id** | **String** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**CountEventsResponse**](CountEventsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## create_event

> <CreateEventResponse> create_event(create_event_request_body, opts)

Create event

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

api_instance = Schematic::EventsApi.new
create_event_request_body = Schematic::CreateEventRequestBody.new({event_type: 'event_type_example'}) # CreateEventRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create event
  result = api_instance.create_event(create_event_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->create_event: #{e}"
end
```

#### Using the create_event_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateEventResponse>, Integer, Hash)> create_event_with_http_info(create_event_request_body, opts)

```ruby
begin
  # Create event
  data, status_code, headers = api_instance.create_event_with_http_info(create_event_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateEventResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->create_event_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_event_request_body** | [**CreateEventRequestBody**](CreateEventRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateEventResponse**](CreateEventResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## get_event

> <GetEventResponse> get_event(event_id, opts)

Get event

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

api_instance = Schematic::EventsApi.new
event_id = 'event_id_example' # String | event_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get event
  result = api_instance.get_event(event_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->get_event: #{e}"
end
```

#### Using the get_event_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetEventResponse>, Integer, Hash)> get_event_with_http_info(event_id, opts)

```ruby
begin
  # Get event
  data, status_code, headers = api_instance.get_event_with_http_info(event_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetEventResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->get_event_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **event_id** | **String** | event_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetEventResponse**](GetEventResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_event_type

> <GetEventTypeResponse> get_event_type(key, opts)

Get event type

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

api_instance = Schematic::EventsApi.new
key = 'key_example' # String | key
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get event type
  result = api_instance.get_event_type(key, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->get_event_type: #{e}"
end
```

#### Using the get_event_type_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetEventTypeResponse>, Integer, Hash)> get_event_type_with_http_info(key, opts)

```ruby
begin
  # Get event type
  data, status_code, headers = api_instance.get_event_type_with_http_info(key, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetEventTypeResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->get_event_type_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **key** | **String** | key |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetEventTypeResponse**](GetEventTypeResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_event_types

> <ListEventTypesResponse> list_event_types(opts)

List event types

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

api_instance = Schematic::EventsApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  q: 'q_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List event types
  result = api_instance.list_event_types(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_event_types: #{e}"
end
```

#### Using the list_event_types_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListEventTypesResponse>, Integer, Hash)> list_event_types_with_http_info(opts)

```ruby
begin
  # List event types
  data, status_code, headers = api_instance.list_event_types_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListEventTypesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_event_types_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **q** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListEventTypesResponse**](ListEventTypesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_events

> <ListEventsResponse> list_events(opts)

List events

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

api_instance = Schematic::EventsApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  feature_id: 'feature_id_example', # String | 
  event_subtype: 'event_subtype_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List events
  result = api_instance.list_events(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_events: #{e}"
end
```

#### Using the list_events_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListEventsResponse>, Integer, Hash)> list_events_with_http_info(opts)

```ruby
begin
  # List events
  data, status_code, headers = api_instance.list_events_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListEventsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_events_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **feature_id** | **String** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListEventsResponse**](ListEventsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_metric_counts

> <ListMetricCountsResponse> list_metric_counts(event_subtype, opts)

List metric counts

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

api_instance = Schematic::EventsApi.new
event_subtype = 'event_subtype_example' # String | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  start_time: Time.parse('2013-10-20T19:20:30+01:00'), # Time | 
  end_time: Time.parse('2013-10-20T19:20:30+01:00'), # Time | 
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example', # String | Order direction
  grouping: 'grouping_example' # String | 
}

begin
  # List metric counts
  result = api_instance.list_metric_counts(event_subtype, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_metric_counts: #{e}"
end
```

#### Using the list_metric_counts_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListMetricCountsResponse>, Integer, Hash)> list_metric_counts_with_http_info(event_subtype, opts)

```ruby
begin
  # List metric counts
  data, status_code, headers = api_instance.list_metric_counts_with_http_info(event_subtype, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListMetricCountsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_metric_counts_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **event_subtype** | **String** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **start_time** | **Time** |  | [optional] |
| **end_time** | **Time** |  | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |
| **grouping** | **String** |  | [optional] |

### Return type

[**ListMetricCountsResponse**](ListMetricCountsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_metric_counts_hourly

> <ListMetricCountsHourlyResponse> list_metric_counts_hourly(event_subtype, opts)

List metric counts hourly

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

api_instance = Schematic::EventsApi.new
event_subtype = 'event_subtype_example' # String | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  start_time: Time.parse('2013-10-20T19:20:30+01:00'), # Time | 
  end_time: Time.parse('2013-10-20T19:20:30+01:00'), # Time | 
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List metric counts hourly
  result = api_instance.list_metric_counts_hourly(event_subtype, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_metric_counts_hourly: #{e}"
end
```

#### Using the list_metric_counts_hourly_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListMetricCountsHourlyResponse>, Integer, Hash)> list_metric_counts_hourly_with_http_info(event_subtype, opts)

```ruby
begin
  # List metric counts hourly
  data, status_code, headers = api_instance.list_metric_counts_hourly_with_http_info(event_subtype, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListMetricCountsHourlyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling EventsApi->list_metric_counts_hourly_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **event_subtype** | **String** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **start_time** | **Time** |  | [optional] |
| **end_time** | **Time** |  | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListMetricCountsHourlyResponse**](ListMetricCountsHourlyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

