# Schematic::EventBodyIdentifyCompany

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **keys** | **Object** | Key-value pairs to identify the company |  |
| **name** | **String** | The display name of the company; required only if it is a new company | [optional] |
| **traits** | **Object** | A map of company trait names to trait values | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::EventBodyIdentifyCompany.new(
  keys: null,
  name: null,
  traits: null
)
```

