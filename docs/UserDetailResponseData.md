# Schematic::UserDetailResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **company_memberships** | [**Array&lt;CompanyMembershipDetailResponseData&gt;**](CompanyMembershipDetailResponseData.md) |  |  |
| **created_at** | **Time** |  |  |
| **environment_id** | **String** |  |  |
| **id** | **String** |  |  |
| **keys** | [**Array&lt;EntityKeyResponseData&gt;**](EntityKeyResponseData.md) |  |  |
| **last_seen_at** | **Time** |  | [optional] |
| **name** | **String** |  |  |
| **traits** | **Object** | A map of trait names to trait values | [optional] |
| **updated_at** | **Time** |  |  |

## Example

```ruby
require 'schematic'

instance = Schematic::UserDetailResponseData.new(
  company_memberships: null,
  created_at: null,
  environment_id: null,
  id: null,
  keys: null,
  last_seen_at: null,
  name: null,
  traits: null,
  updated_at: null
)
```

