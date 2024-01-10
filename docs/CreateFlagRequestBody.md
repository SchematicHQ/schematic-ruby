# Schematic::CreateFlagRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **default_value** | **Boolean** |  |  |
| **description** | **String** |  |  |
| **feature_id** | **String** |  | [optional] |
| **flag_type** | **String** |  |  |
| **key** | **String** |  |  |
| **name** | **String** |  |  |
| **rules** | [**Array&lt;CreateOrUpdateRuleRequestBody&gt;**](CreateOrUpdateRuleRequestBody.md) |  |  |
| **skip_webhooks** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateFlagRequestBody.new(
  default_value: null,
  description: null,
  feature_id: null,
  flag_type: null,
  key: null,
  name: null,
  rules: null,
  skip_webhooks: null
)
```

