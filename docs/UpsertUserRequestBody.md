# Schematic::UpsertUserRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company** | **Object** | Optionally specify company using key/value pairs |  |
| **company_id** | **String** | Optionally specify company using Schematic company ID | [optional] |
| **keys** | **Object** |  |  |
| **last_seen_at** | **Time** |  | [optional] |
| **name** | **String** |  | [optional] |
| **skip_webhooks** | **Boolean** |  | [optional] |
| **traits** | **Object** | A map of trait names to trait values | [optional] |
| **update_only** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::UpsertUserRequestBody.new(
  company: null,
  company_id: null,
  keys: null,
  last_seen_at: null,
  name: null,
  skip_webhooks: null,
  traits: null,
  update_only: null
)
```

