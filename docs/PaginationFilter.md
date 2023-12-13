# Schematic::PaginationFilter

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **dir** | **String** | Order direction | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::PaginationFilter.new(
  dir: null,
  limit: null,
  offset: null,
  order: null
)
```

