# Schematic::CreateOrUpdateRuleRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **id** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **skip_webhooks** | **Boolean** |  | [optional] |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateRuleRequestBody.new(
  condition_groups: null,
  conditions: null,
  id: null,
  name: null,
  priority: null,
  priority_group: null,
  skip_webhooks: null,
  value: null
)
```

