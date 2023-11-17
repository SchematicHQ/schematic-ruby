# Schematic::CreateOrUpdateRuleRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **id** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **priority** | **Integer** |  |  |
| **priority_group** | **Integer** |  | [optional] |
| **value** | **Boolean** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateRuleRequestBody.new(
  conditions: null,
  id: null,
  name: null,
  priority: null,
  priority_group: null,
  value: null
)
```

