# Schematic::CreateOrUpdateConditionGroupRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **flag_id** | **String** |  | [optional] |
| **id** | **String** |  | [optional] |
| **plan_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateConditionGroupRequestBody.new(
  conditions: null,
  flag_id: null,
  id: null,
  plan_id: null
)
```

