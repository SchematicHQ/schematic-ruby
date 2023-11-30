# Schematic::CreateEnvironmentRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_type** | **String** |  |  |
| **name** | **String** |  |  |
| **skip_webhooks** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateEnvironmentRequestBody.new(
  environment_type: null,
  name: null,
  skip_webhooks: null
)
```

