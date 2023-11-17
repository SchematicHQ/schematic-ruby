# Schematic::ListMetricCountsParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  | [optional] |
| **dir** | **String** |  | [optional] |
| **end_time** | **Time** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **grouping** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **order** | **String** |  | [optional] |
| **start_time** | **Time** |  | [optional] |
| **user_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListMetricCountsParams.new(
  company_id: null,
  dir: null,
  end_time: null,
  event_subtype: null,
  grouping: null,
  limit: null,
  offset: null,
  order: null,
  start_time: null,
  user_id: null
)
```

