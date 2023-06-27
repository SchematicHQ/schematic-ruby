# Schematic::EventSummaryResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **environment_id** | **String** |  |  |
| **event_subtype** | **String** |  |  |
| **last_30_company_count** | **Integer** |  |  |
| **last_30_count** | **Integer** |  |  |
| **last_30_user_count** | **Integer** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::EventSummaryResponseData.new(
  environment_id: null,
  event_subtype: null,
  last_30_company_count: null,
  last_30_count: null,
  last_30_user_count: null
)
```

