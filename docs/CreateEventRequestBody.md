# Schematic::CreateEventRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **body** | [**EventBody**](EventBody.md) |  | [optional] |
| **event_type** | **String** | Either &#39;identify&#39; or &#39;track&#39; |  |
| **sent_at** | **Time** | Optionally provide a timestamp at which the event was sent to Schematic | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateEventRequestBody.new(
  body: null,
  event_type: null,
  sent_at: null
)
```

