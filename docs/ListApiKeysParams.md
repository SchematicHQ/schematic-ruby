# Schematic::ListApiKeysParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_id** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **require_environment** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListApiKeysParams.new(
  environment_id: null,
  limit: null,
  offset: null,
  require_environment: null
)
```

