# Schematic::ApiKeyRequestResponseData

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **api_key_id** | **String** |  |  |
| **ended_at** | **Time** |  | [optional] |
| **environment_id** | **String** |  | [optional] |
| **id** | **String** |  |  |
| **method** | **String** |  |  |
| **req_body** | **String** |  | [optional] |
| **resp_body** | **String** |  | [optional] |
| **resp_code** | **Integer** |  | [optional] |
| **started_at** | **Time** |  |  |
| **url** | **String** |  |  |
| **user_agent** | **String** |  | [optional] |

## Example

```ruby
require 'schematic'

instance = Schematic::ApiKeyRequestResponseData.new(
  api_key_id: null,
  ended_at: null,
  environment_id: null,
  id: null,
  method: null,
  req_body: null,
  resp_body: null,
  resp_code: null,
  started_at: null,
  url: null,
  user_agent: null
)
```

