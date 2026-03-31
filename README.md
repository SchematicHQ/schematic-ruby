# Schematic Ruby Library

[![fern shield](https://img.shields.io/badge/%F0%9F%8C%BF-Built%20with%20Fern-brightgreen)](https://buildwithfern.com?utm_source=github&utm_medium=github&utm_campaign=readme&utm_source=https%3A%2F%2Fgithub.com%2Fschematichq%2Fschematic-ruby)

The Schematic Ruby library provides convenient access to the Schematic APIs from Ruby.

## Table of Contents

- [Reference](#reference)
- [Usage](#usage)
- [Environments](#environments)
- [Errors](#errors)
- [Advanced](#advanced)
  - [Retries](#retries)
  - [Timeouts](#timeouts)
  - [Additional Headers](#additional-headers)
  - [Additional Query Parameters](#additional-query-parameters)
- [Contributing](#contributing)

## Reference

A full reference for this library is available [here](https://github.com/schematichq/schematic-ruby/blob/HEAD/./reference.md).

## Usage

Instantiate and use the client with the following:

```ruby
require "schematic"

client = Schematic::Client.new(api_key: "<value>")

client.accounts.create_api_key(name: "name")
```

## Environments

This SDK allows you to configure different environments or custom URLs for API requests. You can either use the predefined environments or specify your own custom URL.
### Environments
```ruby
require "schematic"

schematic = Schematic::Client.new(
    base_url: Schematic::Environment::DEFAULT
)
```

### Custom URL
```ruby
require "schematic"

client = Schematic::Client.new(
    base_url: "https://example.com"
)
```

## Errors

Failed API calls will raise errors that can be rescued from granularly.

```ruby
require "schematic"

client = Schematic::Client.new(
    base_url: "https://example.com"
)

begin
    result = client.accounts.create_api_key
rescue Schematic::Errors::TimeoutError
    puts "API didn't respond before our timeout elapsed"
rescue Schematic::Errors::ServiceUnavailableError
    puts "API returned status 503, is probably overloaded, try again later"
rescue Schematic::Errors::ServerError
    puts "API returned some other 5xx status, this is probably a bug"
rescue Schematic::Errors::ResponseError => e
    puts "API returned an unexpected status other than 5xx: #{e.code} #{e.message}"
rescue Schematic::Errors::ApiError => e
    puts "Some other error occurred when calling the API: #{e.message}"
end
```

## Advanced

### Retries

The SDK is instrumented with automatic retries. A request will be retried as long as the request is deemed
retryable and the number of retry attempts has not grown larger than the configured retry limit (default: 2).

A request is deemed retryable when any of the following HTTP status codes is returned:

- [408](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/408) (Timeout)
- [429](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429) (Too Many Requests)
- [5XX](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/500) (Internal Server Errors)

Use the `max_retries` option to configure this behavior.

```ruby
require "schematic"

client = Schematic::Client.new(
    base_url: "https://example.com",
    max_retries: 3  # Configure max retries (default is 2)
)
```

### Timeouts

The SDK defaults to a 60 second timeout. Use the `timeout` option to configure this behavior.

```ruby
require "schematic"

response = client.accounts.create_api_key(
    ...,
    timeout: 30  # 30 second timeout
)
```

### Additional Headers

If you would like to send additional headers as part of the request, use the `additional_headers` request option.

```ruby
require "schematic"

response = client.accounts.create_api_key(
    ...,
    request_options: {
        additional_headers: {
            "X-Custom-Header" => "custom-value"
        }
    }
)
```

### Additional Query Parameters

If you would like to send additional query parameters as part of the request, use the `additional_query_parameters` request option.

```ruby
require "schematic"

response = client.accounts.create_api_key(
    ...,
    request_options: {
        additional_query_parameters: {
            "custom_param" => "custom-value"
        }
    }
)
```

## Contributing

While we value open-source contributions to this SDK, this library is generated programmatically.
Additions made directly to this library would have to be moved over to our generation code,
otherwise they would be overwritten upon the next generated release. Feel free to open a PR as
a proof of concept, but know that we will not be able to merge it as-is. We suggest opening
an issue first to discuss with us!

On the other hand, contributions to the README are always very welcome!
