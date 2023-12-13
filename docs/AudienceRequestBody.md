# Schematic::AudienceRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **dir** | **String** | Order direction | [optional] |
| **limit** | **Integer** | Page limit (default 100) | [optional] |
| **offset** | **Integer** | Page offset (default 0) | [optional] |
| **order** | **String** | Order by column | [optional] |
| **q** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::AudienceRequestBody.new(
  condition_groups: null,
  conditions: null,
  dir: null,
  limit: null,
  offset: null,
  order: null,
  q: null
)
```

