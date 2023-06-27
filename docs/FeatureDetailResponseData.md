# Schematic::FeatureDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **created_at** | **Time** |  |  |
| **description** | **String** |  |  |
| **event_subtype** | **String** |  | [optional] |
| **event_summary** | [**EventSummaryResponseData**](EventSummaryResponseData.md) |  | [optional] |
| **flags** | [**Array&lt;FlagDetailResponseData&gt;**](FlagDetailResponseData.md) |  |  |
| **id** | **String** |  |  |
| **lifecycle_phase** | **String** |  | [optional] |
| **name** | **String** |  |  |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::FeatureDetailResponseData.new(
  created_at: null,
  description: null,
  event_subtype: null,
  event_summary: null,
  flags: null,
  id: null,
  lifecycle_phase: null,
  name: null,
  updated_at: null
)
```

