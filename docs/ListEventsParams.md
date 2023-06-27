# Schematic::ListEventsParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  | [optional] |
| **dir** | **String** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **feature_id** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **order** | **String** |  | [optional] |
| **user_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListEventsParams.new(
  company_id: null,
  dir: null,
  event_subtype: null,
  feature_id: null,
  limit: null,
  offset: null,
  order: null,
  user_id: null
)
```

