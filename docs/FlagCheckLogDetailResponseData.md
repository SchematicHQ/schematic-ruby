# Schematic::FlagCheckLogDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **check_status** | **String** |  |  |
| **company** | [**CompanyResponseData**](CompanyResponseData.md) |  | [optional] |
| **company_id** | **String** |  | [optional] |
| **created_at** | **Time** |  |  |
| **environment** | [**EnvironmentResponseData**](EnvironmentResponseData.md) |  | [optional] |
| **environment_id** | **String** |  |  |
| **error** | **String** |  | [optional] |
| **flag** | [**FlagResponseData**](FlagResponseData.md) |  | [optional] |
| **flag_id** | **String** |  | [optional] |
| **flag_key** | **String** |  |  |
| **id** | **String** |  |  |
| **reason** | **String** |  |  |
| **req_company** | **Object** |  |  |
| **req_user** | **Object** |  |  |
| **rule** | [**RuleResponseData**](RuleResponseData.md) |  | [optional] |
| **rule_id** | **String** |  | [optional] |
| **updated_at** | **Time** |  |  |
| **user** | [**UserResponseData**](UserResponseData.md) |  | [optional] |
| **user_id** | **String** |  | [optional] |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::FlagCheckLogDetailResponseData.new(
  check_status: null,
  company: null,
  company_id: null,
  created_at: null,
  environment: null,
  environment_id: null,
  error: null,
  flag: null,
  flag_id: null,
  flag_key: null,
  id: null,
  reason: null,
  req_company: null,
  req_user: null,
  rule: null,
  rule_id: null,
  updated_at: null,
  user: null,
  user_id: null,
  value: null
)
```

