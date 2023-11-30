# Schematic::CreateFeatureRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** |  |  |
| **event_subtype** | **String** |  | [optional] |
| **feature_type** | **String** |  |  |
| **flag** | [**CreateOrUpdateFlagRequestBody**](CreateOrUpdateFlagRequestBody.md) |  | [optional] |
| **lifecycle_phase** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **skip_webhooks** | **Boolean** |  | [optional] |
| **trait_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::CreateFeatureRequestBody.new(
  description: null,
  event_subtype: null,
  feature_type: null,
  flag: null,
  lifecycle_phase: null,
  name: null,
  skip_webhooks: null,
  trait_id: null
)
```

