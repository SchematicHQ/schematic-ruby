# Schematic::FeatureDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **created_at** | **Time** |  |  |
| **description** | **String** |  |  |
| **event_subtype** | **String** |  | [optional] |
| **event_summary** | [**EventSummaryResponseData**](EventSummaryResponseData.md) |  | [optional] |
| **feature_type** | **String** |  |  |
| **flags** | [**Array&lt;FlagDetailResponseData&gt;**](FlagDetailResponseData.md) |  |  |
| **id** | **String** |  |  |
| **lifecycle_phase** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **trait_id** | **String** |  | [optional] |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::FeatureDetailResponseData.new(
  created_at: null,
  description: null,
  event_subtype: null,
  event_summary: null,
  feature_type: null,
  flags: null,
  id: null,
  lifecycle_phase: null,
  name: null,
  trait_id: null,
  updated_at: null
)
```

