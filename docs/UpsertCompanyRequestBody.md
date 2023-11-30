# Schematic::UpsertCompanyRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** |  | [optional] |
| **keys** | **Object** |  |  |
| **last_seen_at** | **Time** |  | [optional] |
| **name** | **String** |  | [optional] |
| **skip_webhooks** | **Boolean** |  | [optional] |
| **traits** | **Object** | A map of trait names to trait values | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::UpsertCompanyRequestBody.new(
  id: null,
  keys: null,
  last_seen_at: null,
  name: null,
  skip_webhooks: null,
  traits: null
)
```

