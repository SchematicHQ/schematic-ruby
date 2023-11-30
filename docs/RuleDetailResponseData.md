# Schematic::RuleDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;RuleConditionGroupResponseData&gt;**](RuleConditionGroupResponseData.md) |  |  |
| **conditions** | [**Array&lt;RuleConditionResponseData&gt;**](RuleConditionResponseData.md) |  |  |
| **created_at** | **Time** |  |  |
| **environment_id** | **String** |  |  |
| **flag_id** | **String** |  | [optional] |
| **id** | **String** |  |  |
| **name** | **String** |  |  |
| **plan_id** | **String** |  | [optional] |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **updated_at** | **Time** |  |  |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::RuleDetailResponseData.new(
  condition_groups: null,
  conditions: null,
  created_at: null,
  environment_id: null,
  flag_id: null,
  id: null,
  name: null,
  plan_id: null,
  priority: null,
  priority_group: null,
  updated_at: null,
  value: null
)
```

