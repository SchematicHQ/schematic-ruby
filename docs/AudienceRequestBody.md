# Schematic::AudienceRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **q** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::AudienceRequestBody.new(
  condition_groups: null,
  conditions: null,
  limit: null,
  offset: null,
  q: null
)
```

