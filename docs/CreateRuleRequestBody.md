# Schematic::CreateRuleRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **flag_id** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **plan_id** | **String** |  | [optional] |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **skip_webhooks** | **Boolean** |  | [optional] |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateRuleRequestBody.new(
  condition_groups: null,
  conditions: null,
  flag_id: null,
  name: null,
  plan_id: null,
  priority: null,
  priority_group: null,
  skip_webhooks: null,
  value: null
)
```

