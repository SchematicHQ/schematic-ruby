# Schematic::SyncCompanyPlansRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  | [optional] |
| **plan_id** | **String** |  | [optional] |
| **plans** | [**Array&lt;CreateOrUpdateCompanyPlanRequestBody&gt;**](CreateOrUpdateCompanyPlanRequestBody.md) |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::SyncCompanyPlansRequestBody.new(
  company_id: null,
  plan_id: null,
  plans: null
)
```

