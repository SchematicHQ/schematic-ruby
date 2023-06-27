# Schematic::ListApiKeysParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **dir** | **String** |  | [optional] |
| **environment_id** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **order** | **String** |  | [optional] |
| **require_environment** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListApiKeysParams.new(
  dir: null,
  environment_id: null,
  limit: null,
  offset: null,
  order: null,
  require_environment: null
)
```

