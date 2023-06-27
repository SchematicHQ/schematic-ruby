# Schematic::CompaniesApi

All URIs are relative to *https://api.schematichq.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_company**](CompaniesApi.md#create_company) | **POST** /companies | Create company |
| [**create_company_membership**](CompaniesApi.md#create_company_membership) | **POST** /company-memberships | Create company membership |
| [**create_user**](CompaniesApi.md#create_user) | **POST** /users | Create user |
| [**delete_company_membership**](CompaniesApi.md#delete_company_membership) | **DELETE** /company-memberships/{company_membership_id} | Delete company membership |
| [**get_company**](CompaniesApi.md#get_company) | **GET** /companies/{company_id} | Get company |
| [**get_user**](CompaniesApi.md#get_user) | **GET** /users/{user_id} | Get user |
| [**list_companies**](CompaniesApi.md#list_companies) | **GET** /companies | List companies |
| [**list_company_memberships**](CompaniesApi.md#list_company_memberships) | **GET** /company-memberships | List company memberships |
| [**list_users**](CompaniesApi.md#list_users) | **GET** /users | List users |


## create_company

> <CreateCompanyResponse> create_company(upsert_company_request_body, opts)

Create company

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

api_instance = Schematic::CompaniesApi.new
upsert_company_request_body = Schematic::UpsertCompanyRequestBody.new({keys: 3.56, skip_webhooks: false}) # UpsertCompanyRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create company
  result = api_instance.create_company(upsert_company_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_company: #{e}"
end
```

#### Using the create_company_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateCompanyResponse>, Integer, Hash)> create_company_with_http_info(upsert_company_request_body, opts)

```ruby
begin
  # Create company
  data, status_code, headers = api_instance.create_company_with_http_info(upsert_company_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateCompanyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_company_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **upsert_company_request_body** | [**UpsertCompanyRequestBody**](UpsertCompanyRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateCompanyResponse**](CreateCompanyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_company_membership

> <CreateCompanyMembershipResponse> create_company_membership(get_or_create_company_membership_request_body, opts)

Create company membership

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

api_instance = Schematic::CompaniesApi.new
get_or_create_company_membership_request_body = Schematic::GetOrCreateCompanyMembershipRequestBody.new({company_id: 'company_id_example', user_id: 'user_id_example'}) # GetOrCreateCompanyMembershipRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create company membership
  result = api_instance.create_company_membership(get_or_create_company_membership_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_company_membership: #{e}"
end
```

#### Using the create_company_membership_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateCompanyMembershipResponse>, Integer, Hash)> create_company_membership_with_http_info(get_or_create_company_membership_request_body, opts)

```ruby
begin
  # Create company membership
  data, status_code, headers = api_instance.create_company_membership_with_http_info(get_or_create_company_membership_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateCompanyMembershipResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_company_membership_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **get_or_create_company_membership_request_body** | [**GetOrCreateCompanyMembershipRequestBody**](GetOrCreateCompanyMembershipRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateCompanyMembershipResponse**](CreateCompanyMembershipResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_user

> <CreateUserResponse> create_user(upsert_user_request_body, opts)

Create user

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

api_instance = Schematic::CompaniesApi.new
upsert_user_request_body = Schematic::UpsertUserRequestBody.new({company: 3.56, keys: 3.56, skip_webhooks: false}) # UpsertUserRequestBody | 
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Create user
  result = api_instance.create_user(upsert_user_request_body, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_user: #{e}"
end
```

#### Using the create_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateUserResponse>, Integer, Hash)> create_user_with_http_info(upsert_user_request_body, opts)

```ruby
begin
  # Create user
  data, status_code, headers = api_instance.create_user_with_http_info(upsert_user_request_body, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateUserResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->create_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **upsert_user_request_body** | [**UpsertUserRequestBody**](UpsertUserRequestBody.md) |  |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**CreateUserResponse**](CreateUserResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_company_membership

> <DeleteCompanyMembershipResponse> delete_company_membership(company_membership_id, opts)

Delete company membership

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

api_instance = Schematic::CompaniesApi.new
company_membership_id = 'company_membership_id_example' # String | company_membership_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Delete company membership
  result = api_instance.delete_company_membership(company_membership_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->delete_company_membership: #{e}"
end
```

#### Using the delete_company_membership_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteCompanyMembershipResponse>, Integer, Hash)> delete_company_membership_with_http_info(company_membership_id, opts)

```ruby
begin
  # Delete company membership
  data, status_code, headers = api_instance.delete_company_membership_with_http_info(company_membership_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteCompanyMembershipResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->delete_company_membership_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_membership_id** | **String** | company_membership_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**DeleteCompanyMembershipResponse**](DeleteCompanyMembershipResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_company

> <GetCompanyResponse> get_company(company_id, opts)

Get company

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

api_instance = Schematic::CompaniesApi.new
company_id = 'company_id_example' # String | company_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get company
  result = api_instance.get_company(company_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->get_company: #{e}"
end
```

#### Using the get_company_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetCompanyResponse>, Integer, Hash)> get_company_with_http_info(company_id, opts)

```ruby
begin
  # Get company
  data, status_code, headers = api_instance.get_company_with_http_info(company_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetCompanyResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->get_company_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** | company_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetCompanyResponse**](GetCompanyResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_user

> <GetUserResponse> get_user(user_id, opts)

Get user

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

api_instance = Schematic::CompaniesApi.new
user_id = 'user_id_example' # String | user_id
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example' # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
}

begin
  # Get user
  result = api_instance.get_user(user_id, opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->get_user: #{e}"
end
```

#### Using the get_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetUserResponse>, Integer, Hash)> get_user_with_http_info(user_id, opts)

```ruby
begin
  # Get user
  data, status_code, headers = api_instance.get_user_with_http_info(user_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetUserResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->get_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | user_id |  |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |

### Return type

[**GetUserResponse**](GetUserResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_companies

> <ListCompaniesResponse> list_companies(opts)

List companies

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

api_instance = Schematic::CompaniesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  ids: [37], # Array<Integer> | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List companies
  result = api_instance.list_companies(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_companies: #{e}"
end
```

#### Using the list_companies_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListCompaniesResponse>, Integer, Hash)> list_companies_with_http_info(opts)

```ruby
begin
  # List companies
  data, status_code, headers = api_instance.list_companies_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListCompaniesResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_companies_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **ids** | [**Array&lt;Integer&gt;**](Integer.md) |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListCompaniesResponse**](ListCompaniesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_company_memberships

> <ListCompanyMembershipsResponse> list_company_memberships(opts)

List company memberships

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

api_instance = Schematic::CompaniesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  company_id: 'company_id_example', # String | 
  user_id: 'user_id_example', # String | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List company memberships
  result = api_instance.list_company_memberships(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_company_memberships: #{e}"
end
```

#### Using the list_company_memberships_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListCompanyMembershipsResponse>, Integer, Hash)> list_company_memberships_with_http_info(opts)

```ruby
begin
  # List company memberships
  data, status_code, headers = api_instance.list_company_memberships_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListCompanyMembershipsResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_company_memberships_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **company_id** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListCompanyMembershipsResponse**](ListCompanyMembershipsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_users

> <ListUsersResponse> list_users(opts)

List users

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

api_instance = Schematic::CompaniesApi.new
opts = {
  x_schematic_environment_id: 'x_schematic_environment_id_example', # String | If the request is made using an API key that is not environment-scoped, specify the environment using this header
  ids: [37], # Array<Integer> | 
  limit: 56, # Integer | Page limit (default 100)
  offset: 56, # Integer | Page offset (default 0)
  order: 'order_example', # String | Order by column
  dir: 'dir_example' # String | Order direction
}

begin
  # List users
  result = api_instance.list_users(opts)
  p result
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_users: #{e}"
end
```

#### Using the list_users_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ListUsersResponse>, Integer, Hash)> list_users_with_http_info(opts)

```ruby
begin
  # List users
  data, status_code, headers = api_instance.list_users_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ListUsersResponse>
rescue Schematic::ApiError => e
  puts "Error when calling CompaniesApi->list_users_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **x_schematic_environment_id** | **String** | If the request is made using an API key that is not environment-scoped, specify the environment using this header | [optional] |
| **ids** | [**Array&lt;Integer&gt;**](Integer.md) |  | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **dir** | **String** | Order direction | [optional] |

### Return type

[**ListUsersResponse**](ListUsersResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

