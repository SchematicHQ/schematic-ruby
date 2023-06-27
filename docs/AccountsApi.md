# Schematic::AccountsApi

All URIs are relative to *https://api.schematichq.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**count_api_keys**](AccountsApi.md#count_api_keys) | **GET** /api-keys/count | Count api keys |
| [**create_api_key**](AccountsApi.md#create_api_key) | **POST** /api-keys | Create api key |
| [**create_environment**](AccountsApi.md#create_environment) | **POST** /environments | Create environment |
| [**delete_api_key**](AccountsApi.md#delete_api_key) | **DELETE** /api-keys/{api_key_id} | Delete api key |
| [**delete_environment**](AccountsApi.md#delete_environment) | **DELETE** /environments/{environment_id} | Delete environment |
| [**get_api_key**](AccountsApi.md#get_api_key) | **GET** /api-keys/{api_key_id} | Get api key |
| [**list_api_keys**](AccountsApi.md#list_api_keys) | **GET** /api-keys | List api keys |
| [**update_api_key**](AccountsApi.md#update_api_key) | **PUT** /api-keys/{api_key_id} | Update api key |
| [**update_environment**](AccountsApi.md#update_environment) | **PUT** /environments/{environment_id} | Update environment |


## count_api_keys

> <CountApiKeysResponse> count_api_keys(require_environment, opts)

Count api keys

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

api_instance = Schematic::AccountsApi.new
require_environment = true # Boolean | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  environment_id: 'environment_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # Count api keys
  result = api_instance.count_api_keys(require_environment, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->count_api_keys: #{e}"
end
```

#### Using the count_api_keys_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CountApiKeysResponse>, Integer, Hash)> count_api_keys_with_http_info(require_environment, opts)

```ruby
begin
  # Count api keys
  data, status_code, headers = api_instance.count_api_keys_with_http_info(require_environment, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CountApiKeysResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->count_api_keys_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **require_environment** | **Boolean** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **environment_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**CountApiKeysResponse**](CountApiKeysResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## create_api_key

> <CreateApiKeyResponse> create_api_key(create_api_key_request_body, opts)

Create api key

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

api_instance = Schematic::AccountsApi.new
create_api_key_request_body = Schematic::CreateApiKeyRequestBody.new({name: 'name_example'}) # CreateApiKeyRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create api key
  result = api_instance.create_api_key(create_api_key_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->create_api_key: #{e}"
end
```

#### Using the create_api_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateApiKeyResponse>, Integer, Hash)> create_api_key_with_http_info(create_api_key_request_body, opts)

```ruby
begin
  # Create api key
  data, status_code, headers = api_instance.create_api_key_with_http_info(create_api_key_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateApiKeyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->create_api_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_api_key_request_body** | [**CreateApiKeyRequestBody**](CreateApiKeyRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateApiKeyResponse**](CreateApiKeyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_environment

> <CreateEnvironmentResponse> create_environment(create_environment_request_body, opts)

Create environment

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

api_instance = Schematic::AccountsApi.new
create_environment_request_body = Schematic::CreateEnvironmentRequestBody.new({environment_type: 'environment_type_example', name: 'name_example', skip_webhooks: false}) # CreateEnvironmentRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create environment
  result = api_instance.create_environment(create_environment_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->create_environment: #{e}"
end
```

#### Using the create_environment_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateEnvironmentResponse>, Integer, Hash)> create_environment_with_http_info(create_environment_request_body, opts)

```ruby
begin
  # Create environment
  data, status_code, headers = api_instance.create_environment_with_http_info(create_environment_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateEnvironmentResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->create_environment_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_environment_request_body** | [**CreateEnvironmentRequestBody**](CreateEnvironmentRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateEnvironmentResponse**](CreateEnvironmentResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_api_key

> <DeleteApiKeyResponse> delete_api_key(api_key_id, opts)

Delete api key

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

api_instance = Schematic::AccountsApi.new
api_key_id = 'api_key_id_example' # String | api_key_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete api key
  result = api_instance.delete_api_key(api_key_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->delete_api_key: #{e}"
end
```

#### Using the delete_api_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteApiKeyResponse>, Integer, Hash)> delete_api_key_with_http_info(api_key_id, opts)

```ruby
begin
  # Delete api key
  data, status_code, headers = api_instance.delete_api_key_with_http_info(api_key_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteApiKeyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->delete_api_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **api_key_id** | **String** | api_key_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeleteApiKeyResponse**](DeleteApiKeyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## delete_environment

> <DeleteEnvironmentResponse> delete_environment(environment_id, opts)

Delete environment

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

api_instance = Schematic::AccountsApi.new
environment_id = 'environment_id_example' # String | environment_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete environment
  result = api_instance.delete_environment(environment_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->delete_environment: #{e}"
end
```

#### Using the delete_environment_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteEnvironmentResponse>, Integer, Hash)> delete_environment_with_http_info(environment_id, opts)

```ruby
begin
  # Delete environment
  data, status_code, headers = api_instance.delete_environment_with_http_info(environment_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteEnvironmentResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->delete_environment_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_id** | **String** | environment_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeleteEnvironmentResponse**](DeleteEnvironmentResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_api_key

> <GetApiKeyResponse> get_api_key(api_key_id, opts)

Get api key

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

api_instance = Schematic::AccountsApi.new
api_key_id = 'api_key_id_example' # String | api_key_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get api key
  result = api_instance.get_api_key(api_key_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->get_api_key: #{e}"
end
```

#### Using the get_api_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetApiKeyResponse>, Integer, Hash)> get_api_key_with_http_info(api_key_id, opts)

```ruby
begin
  # Get api key
  data, status_code, headers = api_instance.get_api_key_with_http_info(api_key_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetApiKeyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->get_api_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **api_key_id** | **String** | api_key_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetApiKeyResponse**](GetApiKeyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_api_keys

> <ListApiKeysResponse> list_api_keys(require_environment, opts)

List api keys

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

api_instance = Schematic::AccountsApi.new
require_environment = true # Boolean | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  environment_id: 'environment_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List api keys
  result = api_instance.list_api_keys(require_environment, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->list_api_keys: #{e}"
end
```

#### Using the list_api_keys_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListApiKeysResponse>, Integer, Hash)> list_api_keys_with_http_info(require_environment, opts)

```ruby
begin
  # List api keys
  data, status_code, headers = api_instance.list_api_keys_with_http_info(require_environment, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListApiKeysResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->list_api_keys_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **require_environment** | **Boolean** |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **environment_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListApiKeysResponse**](ListApiKeysResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_api_key

> <UpdateApiKeyResponse> update_api_key(api_key_id, update_api_key_request_body, opts)

Update api key

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

api_instance = Schematic::AccountsApi.new
api_key_id = 'api_key_id_example' # String | api_key_id
update_api_key_request_body = Schematic::UpdateApiKeyRequestBody.new # UpdateApiKeyRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update api key
  result = api_instance.update_api_key(api_key_id, update_api_key_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->update_api_key: #{e}"
end
```

#### Using the update_api_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdateApiKeyResponse>, Integer, Hash)> update_api_key_with_http_info(api_key_id, update_api_key_request_body, opts)

```ruby
begin
  # Update api key
  data, status_code, headers = api_instance.update_api_key_with_http_info(api_key_id, update_api_key_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdateApiKeyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->update_api_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **api_key_id** | **String** | api_key_id |  |
| **update_api_key_request_body** | [**UpdateApiKeyRequestBody**](UpdateApiKeyRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdateApiKeyResponse**](UpdateApiKeyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## update_environment

> <UpdateEnvironmentResponse> update_environment(environment_id, update_environment_request_body, opts)

Update environment

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

api_instance = Schematic::AccountsApi.new
environment_id = 'environment_id_example' # String | environment_id
update_environment_request_body = Schematic::UpdateEnvironmentRequestBody.new # UpdateEnvironmentRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Update environment
  result = api_instance.update_environment(environment_id, update_environment_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->update_environment: #{e}"
end
```

#### Using the update_environment_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UpdateEnvironmentResponse>, Integer, Hash)> update_environment_with_http_info(environment_id, update_environment_request_body, opts)

```ruby
begin
  # Update environment
  data, status_code, headers = api_instance.update_environment_with_http_info(environment_id, update_environment_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UpdateEnvironmentResponse>
rescue Schematic::ApiError => e
  puts "Error when calling AccountsApi->update_environment_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_id** | **String** | environment_id |  |
| **update_environment_request_body** | [**UpdateEnvironmentRequestBody**](UpdateEnvironmentRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**UpdateEnvironmentResponse**](UpdateEnvironmentResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

