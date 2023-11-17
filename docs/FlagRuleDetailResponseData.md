# Schematic::FlagRuleDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **conditions** | [**Array&lt;RuleConditionResponseData&gt;**](RuleConditionResponseData.md) |  |  |
| **created_at** | **Time** |  |  |
| **environment_id** | **String** |  |  |
| **flag_id** | **String** |  |  |
| **id** | **String** |  |  |
| **name** | **String** |  |  |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **updated_at** | **Time** |  |  |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::FlagRuleDetailResponseData.new(
  conditions: null,
  created_at: null,
  environment_id: null,
  flag_id: null,
  id: null,
  name: null,
  priority: null,
  priority_group: null,
  updated_at: null,
  value: null
)
```

