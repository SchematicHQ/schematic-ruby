# Schematic::UpdateAudienceRequestBody

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **condition_groups** | [**Array&lt;CreateOrUpdateConditionGroupRequestBody&gt;**](CreateOrUpdateConditionGroupRequestBody.md) |  |  |
| **conditions** | [**Array&lt;CreateOrUpdateConditionRequestBody&gt;**](CreateOrUpdateConditionRequestBody.md) |  |  |
| **skip_webhooks** | **Boolean** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::UpdateAudienceRequestBody.new(
  condition_groups: null,
  conditions: null,
  skip_webhooks: null
)
```

