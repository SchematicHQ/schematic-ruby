# Schematic::CreateOrUpdateConditionRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_type** | **String** |  |  |
| **event_subtype** | **String** |  | [optional] |
| **id** | **String** |  | [optional] |
| **metric_period** | **String** |  | [optional] |
| **metric_value** | **Integer** |  |  |
| **operator** | **String** |  |  |
| **resource_ids** | **Array&lt;String&gt;** |  |  |
| **trait_id** | **String** |  | [optional] |
| **trait_value** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateConditionRequestBody.new(
  condition_type: null,
  event_subtype: null,
  id: null,
  metric_period: null,
  metric_value: null,
  operator: null,
  resource_ids: null,
  trait_id: null,
  trait_value: null
)
```

