# Schematic::RuleConditionResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_type** | **String** |  |  |
| **created_at** | **Time** |  |  |
| **environment_id** | **String** |  |  |
| **event_subtype** | **String** |  | [optional] |
| **flag_id** | **String** |  |  |
| **id** | **String** |  |  |
| **metric_period** | **String** |  | [optional] |
| **metric_value** | **Integer** |  |  |
| **operator** | **String** |  |  |
| **resource_ids** | **Array&lt;String&gt;** |  |  |
| **rule_id** | **String** |  |  |
| **trait_entity_type** | **String** |  | [optional] |
| **trait_id** | **String** |  | [optional] |
| **trait_value** | **String** |  |  |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::RuleConditionResponseData.new(
  condition_type: null,
  created_at: null,
  environment_id: null,
  event_subtype: null,
  flag_id: null,
  id: null,
  metric_period: null,
  metric_value: null,
  operator: null,
  resource_ids: null,
  rule_id: null,
  trait_entity_type: null,
  trait_id: null,
  trait_value: null,
  updated_at: null
)
```

