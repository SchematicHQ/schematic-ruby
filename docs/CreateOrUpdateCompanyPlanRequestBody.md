# Schematic::CreateOrUpdateCompanyPlanRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  |  |
| **ended_at** | **Time** |  | [optional] |
| **id** | **String** |  | [optional] |
| **plan_id** | **String** |  |  |
| **started_at** | **Time** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateCompanyPlanRequestBody.new(
  company_id: null,
  ended_at: null,
  id: null,
  plan_id: null,
  started_at: null
)
```

