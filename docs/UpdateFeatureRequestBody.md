# Schematic::UpdateFeatureRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** |  | [optional] |
| **event_subtype** | **String** |  | [optional] |
| **feature_type** | **String** |  | [optional] |
| **flag** | [**CreateOrUpdateFlagRequestBody**](CreateOrUpdateFlagRequestBody.md) |  | [optional] |
| **lifecycle_phase** | **String** |  | [optional] |
| **name** | **String** |  | [optional] |
| **skip_webhooks** | **Boolean** |  |  |
| **trait_id** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::UpdateFeatureRequestBody.new(
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

