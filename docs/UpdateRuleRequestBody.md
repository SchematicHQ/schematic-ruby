# Schematic::UpdateRuleRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **name** | **String** |  |  |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::UpdateRuleRequestBody.new(
  condition_groups: null,
  conditions: null,
  name: null,
  priority: null,
  priority_group: null,
  value: null
)
```

