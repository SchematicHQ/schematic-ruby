# Schematic::EventBodyTrack

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company** | **Object** | Key-value pairs to identify company associated with track event | [optional] |
| **event** | **String** | The name of the type of track event |  |
| **traits** | **Object** | A map of trait names to trait values | [optional] |
| **user** | **Object** | Key-value pairs to identify user associated with track event | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::EventBodyTrack.new(
  company: null,
  event: null,
  traits: null,
  user: null
)
```

