# frozen_string_literal: true

require "test_helper"
require "open3"
require "rbconfig"

describe "SDK version metadata" do
  it "loads the version and HTTP client from only the public entrypoint" do
    program = <<~RUBY
      client = Schematic::Internal::Http::RawClient.new(base_url: "https://unused.invalid")
      puts Schematic::VERSION
      puts client.instance_variable_get(:@default_headers)[:"X-Fern-SDK-Version"]
    RUBY
    output, error, status = Open3.capture3(
      RbConfig.ruby, "-I", File.expand_path("../../lib", __dir__), "-r", "schematic", "-e", program
    )

    assert_predicate status, :success?, error
    assert_equal [Schematic::VERSION, Schematic::VERSION], output.lines.map(&:strip)
  end
end
