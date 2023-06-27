# Schematic::ApiKeyCreateResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **created_at** | **Time** |  |  |
| **description** | **String** |  | [optional] |
| **environment_id** | **String** |  | [optional] |
| **id** | **String** |  |  |
| **last_used_at** | **Time** |  | [optional] |
| **name** | **String** |  |  |
| **scopes** | **Array&lt;String&gt;** |  |  |
| **secret** | **String** |  |  |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::ApiKeyCreateResponseData.new(
  created_at: null,
  description: null,
  environment_id: null,
  id: null,
  last_used_at: null,
  name: null,
  scopes: null,
  secret: null,
  updated_at: null
)
```

