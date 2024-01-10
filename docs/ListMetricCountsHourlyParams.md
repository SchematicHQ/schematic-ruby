# Schematic::ListMetricCountsHourlyParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  | [optional] |
| **end_time** | **Time** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **event_subtypes** | **Array&lt;String&gt;** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **start_time** | **Time** |  | [optional] |
| **user_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListMetricCountsHourlyParams.new(
  company_id: null,
  end_time: null,
  event_subtype: null,
  event_subtypes: null,
  limit: null,
  offset: null,
  start_time: null,
  user_id: null
)
```

