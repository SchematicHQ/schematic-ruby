# Schematic::UpdateEnvironmentRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_type** | **String** |  | [optional] |
| **name** | **String** |  | [optional] |
| **skip_webhooks** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::UpdateEnvironmentRequestBody.new(
  environment_type: null,
  name: null,
  skip_webhooks: null
)
```

