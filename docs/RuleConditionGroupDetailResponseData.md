# Schematic::RuleConditionGroupDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **conditions** | [**Array&lt;RuleConditionResponseData&gt;**](RuleConditionResponseData.md) |  |  |
| **created_at** | **Time** |  |  |
| **environment_id** | **String** |  |  |
| **flag_id** | **String** |  | [optional] |
| **id** | **String** |  |  |
| **plan_id** | **String** |  | [optional] |
| **rule_id** | **String** |  |  |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::RuleConditionGroupDetailResponseData.new(
  conditions: null,
  created_at: null,
  environment_id: null,
  flag_id: null,
  id: null,
  plan_id: null,
  rule_id: null,
  updated_at: null
)
```

