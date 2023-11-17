# Schematic::CreateOrUpdateConditionRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **comparison_trait_id** | **String** | Optionally provide a trait ID to compare a metric or trait value against instead of a value | [optional] |
| **condition_type** | **String** |  |  |
| **event_subtype** | **String** | Name of track event type used to measure this condition | [optional] |
| **id** | **String** |  | [optional] |
| **metric_period** | **String** | Period of time over which to measure the track event metric | [optional] |
| **metric_value** | **Integer** | Value to compare the track event metric against |  |
| **operator** | **String** |  |  |
| **resource_ids** | **Array&lt;String&gt;** | List of resource IDs (companise, users, or plans) targeted by this condition |  |
| **trait_id** | **String** | ID of trait to use to measure this condition | [optional] |
| **trait_value** | **String** | Value to compare the trait value against | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateOrUpdateConditionRequestBody.new(
  comparison_trait_id: null,
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

