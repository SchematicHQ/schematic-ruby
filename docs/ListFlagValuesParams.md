# Schematic::ListFlagValuesParams

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_id** | **String** |  | [optional] |
| **entity_type** | **Integer** |  | [optional] |
| **flag_id** | **String** |  | [optional] |
| **limit** | **Integer** |  | [optional] |
| **offset** | **Integer** |  | [optional] |
| **user_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ListFlagValuesParams.new(
  company_id: null,
  entity_type: null,
  flag_id: null,
  limit: null,
  offset: null,
  user_id: null
)
```

