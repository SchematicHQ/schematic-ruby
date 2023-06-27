# Schematic::EventBodyIdentify

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company** | [**EventBodyIdentifyCompany**](EventBodyIdentifyCompany.md) |  | [optional] |
| **keys** | **Object** | Key-value pairs to identify the user |  |
| **name** | **String** | The display name of the user being identified; required only if it is a new user | [optional] |
| **traits** | **Object** | A map of user trait names to trait values | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::EventBodyIdentify.new(
  company: null,
  keys: null,
  name: null,
  traits: null
)
```

