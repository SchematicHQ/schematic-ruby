# Schematic::FlagDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **created_at** | **Time** |  |  |
| **default_value** | **Boolean** |  |  |
| **description** | **String** |  |  |
| **feature_id** | **String** |  | [optional] |
| **flag_type** | **String** |  |  |
| **id** | **String** |  |  |
| **key** | **String** |  |  |
| **name** | **String** |  |  |
| **rules** | [**Array&lt;FlagRuleDetailResponseData&gt;**](FlagRuleDetailResponseData.md) |  |  |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::FlagDetailResponseData.new(
  created_at: null,
  default_value: null,
  description: null,
  feature_id: null,
  flag_type: null,
  id: null,
  key: null,
  name: null,
  rules: null,
  updated_at: null
)
```

