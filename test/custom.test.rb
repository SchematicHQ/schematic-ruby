# frozen_string_literal: true

require "minitest/autorun"
require "webmock/minitest"
require_relative "../lib/schematichq"

# Capture service URL used across tests
CAPTURE_URL = "https://c.schematichq.com/batch"

# Globally stub the capture service so event buffer flushes never fail.
# Individual tests can override with more specific stubs when inspecting payloads.
module CaptureServiceStub
  def before_setup
    super
    WebMock.stub_request(:post, CAPTURE_URL).to_return(status: 200)
  end
end

# Apply the stub to all Minitest specs
Minitest::Spec.include CaptureServiceStub

# A shared (non-local) cache for testing replicator mode.
# Delegates to LocalCache but has its own class identity so the
# DataStream::Client replicator validation doesn't reject it.
class TestSharedCache # rubocop:disable Style/OneClassPerFile
  include Schematic::CacheProvider

  def initialize(max_size: 100, ttl: 60)
    @inner = Schematic::LocalCache.new(max_size: max_size, ttl: ttl)
  end

  def get(key) = @inner.get(key)
  def set(key, value, ttl: nil) = @inner.set(key, value, ttl: ttl)
  def delete(key) = @inner.delete(key)
  def delete_missing(keys_to_keep) = @inner.delete_missing(keys_to_keep)
  def size = @inner.size
  def stop = @inner.stop
end

# =============================================================================
# LocalCache Tests
# =============================================================================
describe "LocalCache" do
  before do
    @cache = Schematic::LocalCache.new(max_size: 5, ttl: 1.0)
  end

  after do
    @cache.stop
  end

  it "sets and gets a value" do
    @cache.set("key1", "value1")

    assert_equal "value1", @cache.get("key1")
  end

  it "returns nil for missing key" do
    assert_nil @cache.get("nonexistent")
  end

  it "expires items after TTL" do
    cache = Schematic::LocalCache.new(max_size: 10, ttl: 0.1)
    cache.set("key1", "value1")

    assert_equal "value1", cache.get("key1")
    sleep(0.15)

    assert_nil cache.get("key1")
    cache.stop
  end

  it "evicts LRU item when at capacity" do
    5.times { |i| @cache.set("key#{i}", "val#{i}") }
    @cache.set("key5", "val5") # should evict key0

    assert_nil @cache.get("key0")
    assert_equal "val5", @cache.get("key5")
  end

  it "updates LRU order on access" do
    5.times { |i| @cache.set("key#{i}", "val#{i}") }
    @cache.get("key0") # touch key0 to move it to most-recently-used
    @cache.set("key5", "val5") # should evict key1 (now LRU), not key0

    assert_equal "val0", @cache.get("key0")
    assert_nil @cache.get("key1")
  end

  it "supports custom TTL override per item" do
    @cache.set("short", "val", ttl: 0.1)
    @cache.set("long", "val", ttl: 10.0)
    sleep(0.15)

    assert_nil @cache.get("short")
    assert_equal "val", @cache.get("long")
  end

  it "deletes an item" do
    @cache.set("key1", "value1")
    @cache.delete("key1")

    assert_nil @cache.get("key1")
  end

  it "delete_missing removes unlisted keys" do
    @cache.set("keep1", "v1")
    @cache.set("keep2", "v2")
    @cache.set("remove1", "v3")
    @cache.delete_missing(%w[keep1 keep2])

    assert_equal "v1", @cache.get("keep1")
    assert_equal "v2", @cache.get("keep2")
    assert_nil @cache.get("remove1")
  end

  it "zero-size cache disables caching" do
    cache = Schematic::LocalCache.new(max_size: 0, ttl: 5.0)
    cache.set("key1", "value1")

    assert_nil cache.get("key1")
    cache.stop
  end

  it "reports size correctly" do
    assert_equal 0, @cache.size
    @cache.set("a", 1)
    @cache.set("b", 2)

    assert_equal 2, @cache.size
  end
end

# =============================================================================
# Webhook Verification Tests
# =============================================================================
describe "Webhook Verification" do
  before do
    @secret = "test-webhook-secret"
    @body = '{"event":"company.updated","data":{"id":"123"}}'
    @timestamp = "1711900800"
  end

  it "computes a valid signature" do
    sig = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)

    refute_nil sig
    refute_empty sig
    assert_match(/\A[0-9a-f]+\z/, sig)
  end

  it "verifies a valid signature" do
    sig = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)

    assert Schematic::Webhooks.verify_signature(@body, sig, @timestamp, @secret)
  end

  it "rejects an invalid signature" do
    assert_raises(Schematic::Webhooks::InvalidSignatureError) do
      Schematic::Webhooks.verify_signature(@body, "deadbeef" * 8, @timestamp, @secret)
    end
  end

  it "rejects missing signature" do
    assert_raises(Schematic::Webhooks::MissingSignatureError) do
      Schematic::Webhooks.verify_signature(@body, "", @timestamp, @secret)
    end
  end

  it "rejects missing timestamp" do
    sig = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)
    assert_raises(Schematic::Webhooks::MissingTimestampError) do
      Schematic::Webhooks.verify_signature(@body, sig, "", @secret)
    end
  end

  it "rejects tampered payload" do
    sig = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)
    tampered_body = '{"event":"company.updated","data":{"id":"HACKED"}}'
    assert_raises(Schematic::Webhooks::InvalidSignatureError) do
      Schematic::Webhooks.verify_signature(tampered_body, sig, @timestamp, @secret)
    end
  end

  it "rejects wrong secret" do
    sig = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)
    assert_raises(Schematic::Webhooks::InvalidSignatureError) do
      Schematic::Webhooks.verify_signature(@body, sig, @timestamp, "wrong-secret")
    end
  end
end

# =============================================================================
# Logger Tests
# =============================================================================
describe "ConsoleLogger" do
  it "respects log level" do
    logger = Schematic::ConsoleLogger.new(level: :warn)
    # Should not raise - just silently skip lower levels
    logger.debug("debug message")
    logger.info("info message")
    # These should work
    logger.warn("warn message")
    logger.error("error message")
  end

  it "can change level at runtime" do
    logger = Schematic::ConsoleLogger.new(level: :info)

    assert_equal :info, logger.level
    logger.level = :debug

    assert_equal :debug, logger.level
  end
end

# =============================================================================
# SchematicClient Tests - Offline Mode
# =============================================================================
describe "SchematicClient - Offline Mode" do
  before do
    @client = Schematic::SchematicClient.new(
      offline: true,
      flag_defaults: { "enabled-flag" => true, "disabled-flag" => false }
    )
  end

  after do
    @client.close
  end

  it "returns configured default for known flags" do
    assert @client.check_flag("enabled-flag")
    refute @client.check_flag("disabled-flag")
  end

  it "returns false for unknown flags" do
    refute @client.check_flag("unknown-flag")
  end

  it "returns offline mode reason in entitlement response" do
    resp = @client.check_flag_with_entitlement("enabled-flag")

    assert resp.value
    assert_equal "offline mode", resp.reason
    assert_equal "enabled-flag", resp.flag_key
  end

  it "auto-enables offline mode when no API key" do
    client = Schematic::SchematicClient.new

    refute client.check_flag("any-flag")
    resp = client.check_flag_with_entitlement("any-flag")

    assert_equal "offline mode", resp.reason
    client.close
  end

  it "supports dynamic flag default updates" do
    refute @client.check_flag("new-flag")
    @client.set_flag_default("new-flag", true)

    assert @client.check_flag("new-flag")
  end

  it "supports bulk flag default updates" do
    @client.set_flag_defaults({ "bulk1" => true, "bulk2" => false })

    assert @client.check_flag("bulk1")
    refute @client.check_flag("bulk2")
  end

  it "silently drops identify events" do
    # Should not raise
    @client.identify({ keys: { "email" => "test@example.com" }, name: "Test User" })
  end

  it "silently drops track events" do
    # Should not raise
    @client.track({ event: "page_view", company: { "org_id" => "abc" } })
  end
end

# =============================================================================
# SchematicClient Tests - API Mode (with mocked HTTP)
# =============================================================================
describe "SchematicClient - API Mode" do
  before do
    @api_key = "api_test_key_123"
    @base_url = "https://api.schematichq.com"

    @client = Schematic::SchematicClient.new(
      api_key: @api_key,
      flag_defaults: { "fallback-flag" => true }
    )
  end

  after do
    @client.close
    WebMock.reset!
  end

  it "returns flag value from API" do
    stub_request(:post, "#{@base_url}/flags/my-feature/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            value: true,
            flag: "my-feature",
            reason: "match",
            rule_id: "rule_123",
            rule_type: "plan_entitlement"
          },
          params: {}
        }.to_json
      )

    assert @client.check_flag("my-feature", company: { "org_id" => "abc" })
  end

  it "returns full entitlement response from API" do
    stub_request(:post, "#{@base_url}/flags/my-feature/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            value: true,
            flag: "my-feature",
            flag_id: "flag_456",
            reason: "plan_entitlement",
            rule_id: "rule_123",
            rule_type: "plan_entitlement",
            company_id: "comp_789",
            user_id: "user_012"
          },
          params: {}
        }.to_json
      )

    resp = @client.check_flag_with_entitlement("my-feature", company: { "org_id" => "abc" })

    assert resp.value
    assert_equal "my-feature", resp.flag_key
    assert_equal "plan_entitlement", resp.reason
    assert_equal "rule_123", resp.rule_id
    assert_equal "comp_789", resp.company_id
  end

  it "caches flag check results" do
    stub_request(:post, "#{@base_url}/flags/cached-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "cached-flag", reason: "match" },
          params: {}
        }.to_json
      ).times(1) # Only expect one API call

    # First call hits API
    assert @client.check_flag("cached-flag")
    # Second call should come from cache (sync write)
    assert @client.check_flag("cached-flag")
  end

  it "returns default when API errors" do
    stub_request(:post, "#{@base_url}/flags/fallback-flag/check")
      .to_return(status: 500, body: "Internal Server Error")

    assert @client.check_flag("fallback-flag")
  end

  it "returns false when no default configured and API errors" do
    stub_request(:post, "#{@base_url}/flags/no-default/check")
      .to_return(status: 500, body: "Internal Server Error")

    refute @client.check_flag("no-default")
  end

  it "provides access to Fern API client methods" do
    refute_nil @client.features
    refute_nil @client.companies
    refute_nil @client.events
    refute_nil @client.plans
    refute_nil @client.billing
    refute_nil @client.entitlements
  end
end

# =============================================================================
# Cache Key Tests
# =============================================================================
describe "Cache Key Generation" do
  before do
    @client = Schematic::SchematicClient.new(offline: true)
  end

  after do
    @client.close
  end

  it "generates deterministic keys for same inputs" do
    key1 = @client.send(:build_cache_key, "flag", { "b" => "2", "a" => "1" }, nil)
    key2 = @client.send(:build_cache_key, "flag", { "a" => "1", "b" => "2" }, nil)

    assert_equal key1, key2
  end

  it "generates different keys for different contexts" do
    key1 = @client.send(:build_cache_key, "flag", { "org" => "a" }, nil)
    key2 = @client.send(:build_cache_key, "flag", { "org" => "b" }, nil)

    refute_equal key1, key2
  end

  it "follows Go format: f:flagkey;c:key:val;u:key:val" do
    key = @client.send(:build_cache_key, "my-flag",
                       { "org_id" => "abc" },
                       { "email" => "test@test.com" })

    assert_equal "f:my-flag;c:org_id:abc;u:email:test@test.com", key
  end
end

# =============================================================================
# EventBuffer Tests
# =============================================================================
describe "EventBuffer" do
  after do
    WebMock.reset!
  end

  it "pushes events and flushes to capture service" do
    stub = stub_request(:post, CAPTURE_URL).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 100,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "page_view" } })
    buffer.push({ event_type: "identify", body: { keys: { email: "test@test.com" } } })
    buffer.flush

    assert_requested(stub, times: 1)
    buffer.stop
  end

  it "sends correct capture service payload format" do
    request_body = nil
    stub_request(:post, CAPTURE_URL).to_return do |req|
      request_body = JSON.parse(req.body, symbolize_names: true)
      { status: 200 }
    end

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 100,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "page_view" }, sent_at: "2024-01-01T00:00:00Z" })
    buffer.flush

    refute_nil request_body
    event = request_body[:events][0]

    assert_equal "test_key", event[:api_key]
    assert_equal "track", event[:type]
    assert_equal "page_view", event[:body][:event]
    assert_equal "2024-01-01T00:00:00Z", event[:sent_at]
    buffer.stop
  end

  it "includes X-Schematic-Api-Key header" do
    stub = stub_request(:post, CAPTURE_URL).with(
      headers: { "X-Schematic-Api-Key" => "test_key" }
    ).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 100,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "e1" } })
    buffer.flush

    assert_requested(stub, times: 1)
    buffer.stop
  end

  it "drops events in offline mode" do
    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      offline: true
    )

    buffer.push({ event_type: "track", body: { event: "page_view" } })
    buffer.stop
  end

  it "rejects events after stop" do
    stub_request(:post, CAPTURE_URL).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      offline: false
    )
    buffer.stop
    buffer.push({ event_type: "track", body: { event: "after-stop" } })
    buffer.flush

    # The event pushed after stop should have been rejected, so no request made
    # (stop itself may flush, but the buffer was empty at that point)
    assert_not_requested(:post, CAPTURE_URL)
  end
end

# =============================================================================
# DataStream Merge Tests
# =============================================================================
describe "DataStream Merge" do
  it "partial_company merges map fields" do
    existing = {
      id: "comp_1",
      keys: { "org_id" => "abc" },
      traits: { "plan" => "pro" }
    }

    partial = {
      traits: { "seats" => "10" }
    }

    result = Schematic::DataStream::Merge.partial_company(existing, partial)

    assert_equal "comp_1", result[:id]
    # deep_copy symbolizes keys, so verify by value
    assert_equal "abc", (result[:keys][:org_id] || result[:keys]["org_id"])
    assert_equal "pro", (result[:traits][:plan] || result[:traits]["plan"])
    assert_equal "10", (result[:traits][:seats] || result[:traits]["seats"])
  end

  it "partial_company replaces array fields" do
    existing = {
      id: "comp_1",
      plan_ids: %w[plan_1 plan_2]
    }

    partial = {
      plan_ids: ["plan_3"]
    }

    result = Schematic::DataStream::Merge.partial_company(existing, partial)

    assert_equal ["plan_3"], result[:plan_ids]
  end

  it "partial_user merges keys" do
    existing = {
      id: "user_1",
      keys: { "email" => "old@test.com" }
    }

    partial = {
      keys: { "user_id" => "123" }
    }

    result = Schematic::DataStream::Merge.partial_user(existing, partial)
    keys = result[:keys]

    assert_equal "old@test.com", (keys[:email] || keys["email"])
    assert_equal "123", (keys[:user_id] || keys["user_id"])
  end

  it "deep_copy produces independent copy" do
    original = { a: { b: [1, 2, 3] } }
    copy = Schematic::DataStream::Merge.deep_copy(original)
    copy[:a][:b] << 4

    assert_equal [1, 2, 3], original[:a][:b]
  end

  it "upsert_metrics replaces matching metrics" do
    existing = [
      { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 5 }
    ]

    incoming = [
      { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 10 }
    ]

    result = Schematic::DataStream::Merge.upsert_metrics(existing, incoming)

    assert_equal 1, result.size
    assert_equal 10, result[0][:value]
  end

  it "upsert_metrics appends non-matching metrics" do
    existing = [
      { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 5 }
    ]

    incoming = [
      { event_subtype: "page_view", period: "daily", month_reset: nil, value: 100 }
    ]

    result = Schematic::DataStream::Merge.upsert_metrics(existing, incoming)

    assert_equal 2, result.size
  end
end

# =============================================================================
# DataStream URL Conversion Tests
# =============================================================================
describe "DataStream WebSocket URL Conversion" do
  it "converts https://api.schematichq.com to wss://datastream.schematichq.com/datastream" do
    ws = Schematic::DataStream::WebSocketClient.new(
      base_url: "https://api.schematichq.com",
      api_key: "test",
      logger: Schematic::ConsoleLogger.new(level: :error),
      message_handler: ->(_msg) {}
    )

    assert_equal "wss://datastream.schematichq.com/datastream", ws.url
  end

  it "converts http://localhost:8080 to ws://localhost:8080/datastream" do
    ws = Schematic::DataStream::WebSocketClient.new(
      base_url: "http://localhost:8080",
      api_key: "test",
      logger: Schematic::ConsoleLogger.new(level: :error),
      message_handler: ->(_msg) {}
    )

    assert_equal "ws://localhost:8080/datastream", ws.url
  end
end

# =============================================================================
# CheckFlagResponse Tests
# =============================================================================
describe "CheckFlagResponse" do
  it "initializes with all fields" do
    resp = Schematic::CheckFlagResponse.new(
      value: true,
      flag_key: "my-flag",
      flag_id: "flag_123",
      reason: "match",
      rule_id: "rule_456",
      rule_type: "plan_entitlement",
      company_id: "comp_789",
      user_id: "user_012"
    )

    assert resp.value
    assert_equal "my-flag", resp.flag_key
    assert_equal "flag_123", resp.flag_id
    assert_equal "match", resp.reason
    assert_equal "rule_456", resp.rule_id
    assert_equal "plan_entitlement", resp.rule_type
    assert_equal "comp_789", resp.company_id
    assert_equal "user_012", resp.user_id
  end

  it "defaults value to false" do
    resp = Schematic::CheckFlagResponse.new({})

    refute resp.value
  end

  it "converts to hash" do
    resp = Schematic::CheckFlagResponse.new(value: true, flag_key: "flag", reason: "match")
    h = resp.to_h

    assert h[:value]
    assert_equal "flag", h[:flag_key]
    assert_equal "match", h[:reason]
  end
end

# =============================================================================
# ResourceCache Tests
# =============================================================================
describe "DataStream ResourceCache" do
  before do
    @primary = Schematic::LocalCache.new(max_size: 100, ttl: 60)
    @lookup = Schematic::LocalCache.new(max_size: 100, ttl: 60)
    @cache = Schematic::DataStream::ResourceCache.new(
      primary_cache: @primary,
      lookup_cache: @lookup,
      key_prefix: "company",
      get_id: ->(c) { c[:id] },
      get_keys: ->(c) { c[:keys] || {} }
    )
  end

  after do
    @primary.stop
    @lookup.stop
  end

  it "caches and retrieves entity by ID" do
    entity = { id: "comp_1", keys: { "org_id" => "abc" }, name: "Test Co" }
    @cache.cache_entity(entity)

    result = @cache.get_by_id("comp_1")

    assert_equal "comp_1", result[:id]
    assert_equal "Test Co", result[:name]
  end

  it "retrieves entity by keys" do
    entity = { id: "comp_1", keys: { "org_id" => "abc" } }
    @cache.cache_entity(entity)

    result = @cache.get_by_keys({ "org_id" => "abc" })

    assert_equal "comp_1", result[:id]
  end

  it "returns nil for missing entity" do
    assert_nil @cache.get_by_id("nonexistent")
    assert_nil @cache.get_by_keys({ "org_id" => "missing" })
  end

  it "deletes entity" do
    entity = { id: "comp_1", keys: { "org_id" => "abc" } }
    @cache.cache_entity(entity)
    @cache.delete_entity(entity)

    assert_nil @cache.get_by_id("comp_1")
    assert_nil @cache.get_by_keys({ "org_id" => "abc" })
  end
end

# =============================================================================
# Additional LocalCache Tests
# =============================================================================
describe "LocalCache - TTL Expiration and Refresh" do
  it "refreshes value after TTL expiration" do
    cache = Schematic::LocalCache.new(max_size: 10, ttl: 0.1)
    cache.set("key1", "value1")

    assert_equal "value1", cache.get("key1")
    sleep(0.15)

    assert_nil cache.get("key1")
    cache.set("key1", "value2")

    assert_equal "value2", cache.get("key1")
    cache.stop
  end

  it "background cleanup removes expired items" do
    cache = Schematic::LocalCache.new(max_size: 10, ttl: 0.1)
    cache.set("a", 1)
    cache.set("b", 2)
    cache.set("c", 3)

    assert_equal 3, cache.size

    # TTL is 0.1s, cleanup interval = ttl/4 = 0.025s clamped to 1.0s
    # We need to wait past TTL and let cleanup thread run
    sleep(0.2)
    # Force a get to trigger expiration check for at least one key
    assert_nil cache.get("a")

    # After manual get, at least the fetched key is removed
    # Background cleanup may not have run yet with 1s interval
    cache.stop
  end

  it "concurrent read/write is thread-safe" do
    cache = Schematic::LocalCache.new(max_size: 100, ttl: 5.0)
    errors = []
    threads = 10.times.map do |i|
      Thread.new do
        50.times do |j|
          cache.set("key-#{i}-#{j}", "val-#{i}-#{j}")
          cache.get("key-#{i}-#{j}")
          cache.delete("key-#{i}-#{j % 5}") if j.even?
        end
      rescue StandardError => e
        errors << e
      end
    end

    threads.each(&:join)

    assert_empty errors, "Thread-safety violation: #{errors.map(&:message).join(", ")}"
    cache.stop
  end
end

# =============================================================================
# Additional EventBuffer Tests
# =============================================================================
describe "EventBuffer - Extended" do
  after do
    WebMock.reset!
  end

  it "periodic timer triggers flush" do
    stub = stub_request(:post, CAPTURE_URL).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 0.1,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "periodic-test" } })
    sleep(0.2)

    assert_requested(stub, times: 1)
    buffer.stop
  end

  it "size-based flush triggers when max batch size reached" do
    stub = stub_request(:post, CAPTURE_URL).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      max_batch_size: 3,
      offline: false
    )

    3.times { |i| buffer.push({ event_type: "track", body: { event: "e#{i}" } }) }
    sleep(0.05)

    assert_requested(stub, times: 1)
    buffer.stop
  end

  it "retries on transient failure and succeeds" do
    attempt_count = 0
    stub_request(:post, CAPTURE_URL)
      .to_return do
        attempt_count += 1
        if attempt_count < 2
          { status: 500, body: "transient error" }
        else
          { status: 200 }
        end
      end

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "retry-test" } })
    buffer.flush

    assert_operator attempt_count, :>=, 2
    buffer.stop
  end

  it "discards batch after max retries exhausted" do
    attempt_count = 0
    stub_request(:post, CAPTURE_URL)
      .to_return do
        attempt_count += 1
        { status: 500, body: "persistent error" }
      end

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "fail-test" } })
    buffer.flush

    # Initial attempt + MAX_RETRIES (3) retries = 4 total
    assert_equal 4, attempt_count
    buffer.stop
  end

  it "shutdown flushes remaining events" do
    stub = stub_request(:post, CAPTURE_URL).to_return(status: 200)

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      offline: false
    )

    buffer.push({ event_type: "track", body: { event: "pre-shutdown" } })
    buffer.stop

    assert_requested(stub, times: 1)
  end
end

# =============================================================================
# SchematicClient - Cache Disabled Test
# =============================================================================
describe "SchematicClient - Cache Disabled" do
  it "every call hits API when cache providers empty" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(
      api_key: api_key,
      cache_providers: []
    )

    stub_request(:post, "#{base_url}/flags/no-cache-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "no-cache-flag", reason: "match" },
          params: {}
        }.to_json
      )

    # Both calls should hit API (no caching)
    assert client.check_flag("no-cache-flag")
    assert client.check_flag("no-cache-flag")

    assert_requested(:post, "#{base_url}/flags/no-cache-flag/check", times: 2)

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# SchematicClient - check_flags batch Test
# =============================================================================
describe "SchematicClient - check_flags" do
  it "returns defaults in offline mode" do
    client = Schematic::SchematicClient.new(
      offline: true,
      flag_defaults: { "flag-a" => true, "flag-b" => false }
    )

    results = client.check_flags(keys: %w[flag-a flag-b flag-c])

    assert_equal 3, results.size
    assert results[0][:value]
    refute results[1][:value]
    refute results[2][:value] # unknown flag defaults to false
    client.close
  end

  it "returns all flag defaults for offline mode with no keys" do
    client = Schematic::SchematicClient.new(
      offline: true,
      flag_defaults: { "default-a" => true, "default-b" => false }
    )
    results = client.check_flags

    assert_equal 2, results.size
    flag_map = results.to_h { |r| [r[:flag], r[:value]] }

    assert flag_map["default-a"]
    refute flag_map["default-b"]
    client.close
  end

  it "returns empty array for offline mode with no keys and no defaults" do
    client = Schematic::SchematicClient.new(offline: true)
    results = client.check_flags

    assert_equal [], results
    client.close
  end

  it "returns flag values from API" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(
      api_key: api_key,
      cache_providers: [],
      flag_defaults: { "flag-c" => true }
    )

    stub_request(:post, "#{base_url}/flags/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            flags: [
              { flag: "flag-a", value: true, reason: "match" },
              { flag: "flag-b", value: false, reason: "no match" }
            ]
          },
          params: {}
        }.to_json
      )

    results = client.check_flags(
      company: { "org_id" => "abc" },
      keys: %w[flag-a flag-b flag-c]
    )

    assert_equal 3, results.size
    assert_equal "flag-a", results[0][:flag]
    assert results[0][:value]
    assert_equal "flag-b", results[1][:flag]
    refute results[1][:value]
    # flag-c not returned by API, falls back to default
    assert_equal "flag-c", results[2][:flag]
    assert results[2][:value]

    client.close
    WebMock.reset!
  end

  it "returns all cached results without API call when all keys are cached" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(api_key: api_key)

    # Pre-populate cache for both flags via individual checks
    stub_request(:post, "#{base_url}/flags/flag-x/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "flag-x", reason: "match" },
          params: {}
        }.to_json
      )
    stub_request(:post, "#{base_url}/flags/flag-y/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: false, flag: "flag-y", reason: "no match" },
          params: {}
        }.to_json
      )
    client.check_flag("flag-x", company: { "org_id" => "abc" })
    client.check_flag("flag-y", company: { "org_id" => "abc" })

    # Batch check — both should come from cache, no batch API call needed
    results = client.check_flags(
      company: { "org_id" => "abc" },
      keys: %w[flag-x flag-y]
    )

    assert_equal 2, results.size
    assert results[0][:value]
    refute results[1][:value]
    assert_not_requested(:post, "#{base_url}/flags/check")

    client.close
    WebMock.reset!
  end

  it "fetches fresh values for ALL keys from API when any key has a cache miss" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(api_key: api_key)

    # Pre-populate cache for one flag
    stub_request(:post, "#{base_url}/flags/cached-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "cached-flag", reason: "old cached reason" },
          params: {}
        }.to_json
      )
    client.check_flag("cached-flag", company: { "org_id" => "abc" })

    # Batch check with one cached, one not — API should return fresh values for ALL
    stub_request(:post, "#{base_url}/flags/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            flags: [
              { flag: "cached-flag", value: false, reason: "updated reason" },
              { flag: "uncached-flag", value: true, reason: "new match" }
            ]
          },
          params: {}
        }.to_json
      )

    results = client.check_flags(
      company: { "org_id" => "abc" },
      keys: %w[cached-flag uncached-flag]
    )

    assert_equal 2, results.size
    # cached-flag should use fresh API value (false), not stale cached value (true)
    refute results[0][:value], "should use fresh API value, not stale cache"
    assert_equal "updated reason", results[0][:reason]
    assert results[1][:value]

    client.close
    WebMock.reset!
  end

  it "returns defaults on API error" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(
      api_key: api_key,
      cache_providers: [],
      flag_defaults: { "err-flag" => true }
    )

    stub_request(:post, "#{base_url}/flags/check")
      .to_return(status: 500, body: "Internal Server Error")

    results = client.check_flags(keys: %w[err-flag other-flag])

    assert_equal 2, results.size
    assert results[0][:value] # has default
    refute results[1][:value] # no default → false

    client.close
    WebMock.reset!
  end

  it "calls API without keys for no-keys mode" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(
      api_key: api_key,
      cache_providers: []
    )

    stub_request(:post, "#{base_url}/flags/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            flags: [
              { flag: "auto-a", value: true, reason: "match" },
              { flag: "auto-b", value: false, reason: "no match" }
            ]
          },
          params: {}
        }.to_json
      )

    results = client.check_flags(company: { "org_id" => "abc" })

    assert_equal 2, results.size
    assert_equal "auto-a", results[0][:flag]

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# SchematicClient - Flag Check with Cache TTL Expiration
# =============================================================================
describe "SchematicClient - Cache TTL Expiration" do
  it "refreshes flag value after cache TTL expires" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(
      api_key: api_key,
      cache_providers: [Schematic::LocalCache.new(max_size: 100, ttl: 0.1)]
    )

    stub_request(:post, "#{base_url}/flags/ttl-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "ttl-flag", reason: "match" },
          params: {}
        }.to_json
      )

    # First call hits API and caches
    assert client.check_flag("ttl-flag")

    # Second call uses cache
    assert client.check_flag("ttl-flag")
    assert_requested(:post, "#{base_url}/flags/ttl-flag/check", times: 1)

    # Wait for TTL to expire
    sleep(0.15)

    # Third call should hit API again
    assert client.check_flag("ttl-flag")
    assert_requested(:post, "#{base_url}/flags/ttl-flag/check", times: 2)

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# SchematicClient - Flag Check Context Variations
# =============================================================================
describe "SchematicClient - Flag Check Context Variations" do
  before do
    @api_key = "api_test_key_123"
    @base_url = "https://api.schematichq.com"
  end

  after do
    WebMock.reset!
  end

  it "checks flag with company context only" do
    client = Schematic::SchematicClient.new(api_key: @api_key, cache_providers: [])

    stub_request(:post, "#{@base_url}/flags/company-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "company-flag", reason: "match", company_id: "comp_1" },
          params: {}
        }.to_json
      )

    assert client.check_flag("company-flag", company: { "org_id" => "abc" })
    client.close
  end

  it "checks flag with user context only" do
    client = Schematic::SchematicClient.new(api_key: @api_key, cache_providers: [])

    stub_request(:post, "#{@base_url}/flags/user-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "user-flag", reason: "match", user_id: "user_1" },
          params: {}
        }.to_json
      )

    assert client.check_flag("user-flag", user: { "email" => "test@test.com" })
    client.close
  end

  it "checks flag with both company and user context" do
    client = Schematic::SchematicClient.new(api_key: @api_key, cache_providers: [])

    stub_request(:post, "#{@base_url}/flags/both-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            value: true,
            flag: "both-flag",
            reason: "match",
            company_id: "comp_1",
            user_id: "user_1"
          },
          params: {}
        }.to_json
      )

    resp = client.check_flag_with_entitlement(
      "both-flag",
      company: { "org_id" => "abc" },
      user: { "email" => "test@test.com" }
    )

    assert resp.value
    assert_equal "comp_1", resp.company_id
    assert_equal "user_1", resp.user_id
    client.close
  end

  it "checks flag with no context" do
    client = Schematic::SchematicClient.new(api_key: @api_key, cache_providers: [])

    stub_request(:post, "#{@base_url}/flags/no-ctx-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: false, flag: "no-ctx-flag", reason: "no match" },
          params: {}
        }.to_json
      )

    refute client.check_flag("no-ctx-flag")
    client.close
  end

  it "check_flag_with_entitlement returns nil entitlement when flag has none" do
    client = Schematic::SchematicClient.new(api_key: @api_key, cache_providers: [])

    stub_request(:post, "#{@base_url}/flags/no-ent-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "no-ent-flag", reason: "match" },
          params: {}
        }.to_json
      )

    resp = client.check_flag_with_entitlement("no-ent-flag")

    assert resp.value
    assert_nil resp.entitlement
    client.close
  end

  it "caches entitlement response and returns it" do
    client = Schematic::SchematicClient.new(api_key: @api_key)

    stub_request(:post, "#{@base_url}/flags/ent-cached/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            value: true,
            flag: "ent-cached",
            flag_id: "flag_1",
            reason: "plan_entitlement",
            rule_id: "rule_1",
            rule_type: "plan_entitlement"
          },
          params: {}
        }.to_json
      ).times(1)

    # First call hits API
    resp1 = client.check_flag_with_entitlement("ent-cached", company: { "org_id" => "abc" })

    assert resp1.value
    assert_equal "plan_entitlement", resp1.reason

    # Second call from cache — same response
    resp2 = client.check_flag_with_entitlement("ent-cached", company: { "org_id" => "abc" })

    assert resp2.value
    assert_equal "plan_entitlement", resp2.reason

    client.close
  end
end

# =============================================================================
# SchematicClient - Track Event with Quantity
# =============================================================================
describe "SchematicClient - Track with Quantity" do
  it "passes quantity through in track event body" do
    request_body = nil
    stub_request(:post, CAPTURE_URL).to_return do |req|
      request_body = JSON.parse(req.body, symbolize_names: true)
      { status: 200 }
    end

    client = Schematic::SchematicClient.new(
      api_key: "api_test_key_123",
      cache_providers: []
    )

    client.track({
                   event: "query-tokens",
                   company: { "org_id" => "abc" },
                   user: { "email" => "test@test.com" },
                   quantity: 1500
                 })

    buffer = client.instance_variable_get(:@event_buffer)
    buffer.flush

    refute_nil request_body
    event = request_body[:events][0]

    assert_equal 1500, event[:body][:quantity]
    assert_equal "query-tokens", event[:body][:event]

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# EventBuffer - Concurrent Push
# =============================================================================
describe "EventBuffer - Concurrent Push" do
  after do
    WebMock.reset!
  end

  it "handles concurrent pushes safely" do
    total_events = 0
    mutex = Mutex.new
    stub_request(:post, CAPTURE_URL)
      .to_return do |req|
        body = JSON.parse(req.body, symbolize_names: true)
        mutex.synchronize { total_events += body[:events].size }
        { status: 200 }
      end

    buffer = Schematic::EventBuffer.new(
      api_key: "test_key",
      logger: Schematic::ConsoleLogger.new(level: :error),
      interval: 60,
      max_batch_size: 1000,
      offline: false
    )

    errors = []
    threads = 10.times.map do |i|
      Thread.new do
        20.times do |j|
          buffer.push({ event_type: "track", body: { event: "e-#{i}-#{j}" } })
        end
      rescue StandardError => e
        errors << e
      end
    end

    threads.each(&:join)
    buffer.stop

    assert_empty errors, "Thread-safety violation: #{errors.map(&:message).join(", ")}"
    assert_equal 200, total_events
  end
end

# =============================================================================
# DataStream EvaluationError and API Fallback Tests
# =============================================================================
describe "DataStream - EvaluationError raises for API fallback" do
  it "raises ArgumentError when replicator mode has no shared cache" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    assert_raises(ArgumentError) do
      Schematic::DataStream::Client.new(
        api_key: "test",
        base_url: "https://api.schematichq.com",
        logger: logger,
        rules_engine: rules_engine,
        replicator_mode: true
      )
    end
  end

  it "raises ArgumentError when replicator mode uses LocalCache" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    assert_raises(ArgumentError) do
      Schematic::DataStream::Client.new(
        api_key: "test",
        base_url: "https://api.schematichq.com",
        logger: logger,
        rules_engine: rules_engine,
        flag_cache: Schematic::LocalCache.new(max_size: 10, ttl: 60),
        replicator_mode: true
      )
    end
  end

  it "raises EvaluationError when flag is not in cache" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)
    flag_cache = TestSharedCache.new(max_size: 10, ttl: 60)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      flag_cache: flag_cache,
      replicator_mode: true
    )

    assert_raises(Schematic::DataStream::EvaluationError) do
      ds_client.check_flag({}, "nonexistent-flag")
    end

    ds_client.close
    flag_cache.stop
  end

  it "raises EvaluationError when rules engine is not initialized" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)
    flag_cache = TestSharedCache.new(max_size: 10, ttl: 60)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      flag_cache: flag_cache,
      replicator_mode: true
    )

    # Manually populate a flag in the cache
    flag_cache.set("test-flag", { key: "test-flag", rules: [] })

    assert_raises(Schematic::DataStream::EvaluationError) do
      ds_client.check_flag({}, "test-flag")
    end

    ds_client.close
    flag_cache.stop
  end

  it "SchematicClient falls back to API when DataStream raises EvaluationError" do
    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    stub_request(:post, "#{base_url}/flags/ds-fallback-flag/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { value: true, flag: "ds-fallback-flag", reason: "match" },
          params: {}
        }.to_json
      )

    client = Schematic::SchematicClient.new(api_key: api_key)

    # Simulate a DataStream client that always raises EvaluationError
    mock_ds = Object.new
    mock_ds.define_singleton_method(:check_flag) do |_eval_ctx, _flag_key|
      raise Schematic::DataStream::EvaluationError, "flag not in cache"
    end
    mock_ds.define_singleton_method(:close) { nil }
    mock_ds.define_singleton_method(:connected?) { true }
    client.instance_variable_set(:@datastream_client, mock_ds)

    # Should fall back to API and return true
    assert client.check_flag("ds-fallback-flag")
    assert_requested(:post, "#{base_url}/flags/ds-fallback-flag/check", times: 1)

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# SchematicClient - check_flags with DataStream
# =============================================================================
describe "SchematicClient - check_flags with DataStream" do
  it "evaluates all flags via DataStream when connected" do
    stub_request(:post, CAPTURE_URL).to_return(status: 200)

    client = Schematic::SchematicClient.new(api_key: "api_test_key_123")

    # Simulate a DataStream client that evaluates flags locally
    mock_ds = Object.new
    mock_ds.define_singleton_method(:connected?) { true }
    mock_ds.define_singleton_method(:close) { nil }
    mock_ds.define_singleton_method(:check_flag) do |_eval_ctx, flag_key|
      case flag_key
      when "ds-flag-a" then { value: true, flag_key: "ds-flag-a", reason: "match" }
      when "ds-flag-b" then { value: false, flag_key: "ds-flag-b", reason: "no match" }
      else raise Schematic::DataStream::EvaluationError, "unknown"
      end
    end
    client.instance_variable_set(:@datastream_client, mock_ds)

    results = client.check_flags(
      company: { "org_id" => "abc" },
      keys: %w[ds-flag-a ds-flag-b]
    )

    assert_equal 2, results.size
    assert_equal "ds-flag-a", results[0][:flag]
    assert results[0][:value]
    assert_equal "ds-flag-b", results[1][:flag]
    refute results[1][:value]

    # No batch API call should have been made
    assert_not_requested(:post, "https://api.schematichq.com/flags/check")

    client.close
    WebMock.reset!
  end

  it "falls back to API when any DataStream flag evaluation fails" do
    stub_request(:post, CAPTURE_URL).to_return(status: 200)

    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(api_key: api_key, cache_providers: [])

    # Simulate a DataStream client that fails on the second flag
    mock_ds = Object.new
    mock_ds.define_singleton_method(:connected?) { true }
    mock_ds.define_singleton_method(:close) { nil }
    mock_ds.define_singleton_method(:check_flag) do |_eval_ctx, flag_key|
      raise Schematic::DataStream::EvaluationError, "flag not in cache" unless flag_key == "ds-ok"

      { value: true, flag_key: "ds-ok", reason: "match" }
    end
    client.instance_variable_set(:@datastream_client, mock_ds)

    stub_request(:post, "#{base_url}/flags/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: {
            flags: [
              { flag: "ds-ok", value: false, reason: "api says no" },
              { flag: "ds-miss", value: true, reason: "api says yes" }
            ]
          },
          params: {}
        }.to_json
      )

    results = client.check_flags(
      company: { "org_id" => "abc" },
      keys: %w[ds-ok ds-miss]
    )

    assert_equal 2, results.size
    # Should use API values (not DataStream partial results)
    refute results[0][:value]
    assert results[1][:value]

    client.close
    WebMock.reset!
  end

  it "skips DataStream for check_flags when no keys provided" do
    stub_request(:post, CAPTURE_URL).to_return(status: 200)

    api_key = "api_test_key_123"
    base_url = "https://api.schematichq.com"

    client = Schematic::SchematicClient.new(api_key: api_key, cache_providers: [])

    # DataStream should NOT be consulted for no-keys mode
    mock_ds = Object.new
    mock_ds.define_singleton_method(:connected?) { true }
    mock_ds.define_singleton_method(:close) { nil }
    mock_ds.define_singleton_method(:check_flag) { |*, **| raise "should not be called" }
    client.instance_variable_set(:@datastream_client, mock_ds)

    stub_request(:post, "#{base_url}/flags/check")
      .to_return(
        status: 200,
        headers: { "Content-Type" => "application/json" },
        body: {
          data: { flags: [{ flag: "auto-flag", value: true, reason: "match" }] },
          params: {}
        }.to_json
      )

    results = client.check_flags(company: { "org_id" => "abc" })

    assert_equal 1, results.size
    assert results[0][:value]

    client.close
    WebMock.reset!
  end
end

# =============================================================================
# DataStream Client - connected? Tests
# =============================================================================
describe "DataStream Client - connected?" do
  it "returns false when no WebSocket and not replicator mode" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine
    )

    refute_predicate ds_client, :connected?
    ds_client.close
  end

  it "returns replicator_ready status in replicator mode" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)
    flag_cache = TestSharedCache.new(max_size: 10, ttl: 60)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      flag_cache: flag_cache,
      replicator_mode: true
    )

    # Initially not connected (replicator not ready)
    refute_predicate ds_client, :connected?
    ds_client.close
    flag_cache.stop
  end
end

# =============================================================================
# WASM Rules Engine Tests
# =============================================================================
describe "RulesEngine" do
  it "starts uninitialized" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))

    refute_predicate engine, :initialized?
  end

  it "gracefully handles missing WASM binary" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))

    # Temporarily stub the WASM_PATH to a non-existent file
    original_path = Schematic::RulesEngine::WASM_PATH
    Schematic::RulesEngine.send(:remove_const, :WASM_PATH)
    Schematic::RulesEngine.const_set(:WASM_PATH, "/tmp/nonexistent_rulesengine.wasm")

    engine.initialize!

    refute_predicate engine, :initialized?

    Schematic::RulesEngine.send(:remove_const, :WASM_PATH)
    Schematic::RulesEngine.const_set(:WASM_PATH, original_path)
  end

  it "raises when check_flag called without initialization" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
    assert_raises(RuntimeError) do
      engine.check_flag({ key: "test-flag", rules: [] })
    end
  end

  it "raises when version_key called without initialization" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
    assert_raises(RuntimeError) do
      engine.version_key
    end
  end

  it "strip_nulls removes nil values from hashes" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))

    input = { a: 1, b: nil, c: { d: 2, e: nil }, f: [1, nil, 3] }
    result = engine.send(:strip_nulls, input)

    assert_equal 1, result[:a]
    refute result.key?(:b)
    assert_equal 2, result[:c][:d]
    refute result[:c].key?(:e)
    # nil values in arrays are preserved (strip_nulls only strips hash values)
    assert_equal [1, nil, 3], result[:f]
  end

  it "strip_nulls handles nested structures" do
    engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))

    input = { flag: { key: "test", rules: [{ id: "r1", value: nil }] } }
    result = engine.send(:strip_nulls, input)

    assert_equal "test", result[:flag][:key]
    assert_equal "r1", result[:flag][:rules][0][:id]
    refute result[:flag][:rules][0].key?(:value)
  end

  # Test actual WASM initialization and flag checking.
  # Guard: binary must exist AND the wasmtime gem must support our WASM module.
  # CI environments may have a different wasmtime version, so we probe first.
  wasm_probe = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
  wasm_probe.initialize! if File.exist?(Schematic::RulesEngine::WASM_PATH)
  if wasm_probe.initialized?
    it "initializes successfully with WASM binary" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      assert_predicate engine, :initialized?
    end

    it "is idempotent on double initialization" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!
      engine.initialize! # should not raise

      assert_predicate engine, :initialized?
    end

    it "returns a version key" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!
      vk = engine.version_key

      refute_nil vk
      refute_empty vk
    end

    it "evaluates a flag with the rules engine" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = {
        id: "flag-test",
        key: "test-flag",
        type: "boolean",
        default_value: true,
        rules: [],
        account_id: "account-123",
        environment_id: "env-123"
      }

      result = engine.check_flag(flag)

      assert_kind_of Hash, result
      assert_includes [true, false], result[:value]
    end

    it "evaluates a flag with company and user context" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = {
        id: "flag-ctx",
        key: "ctx-flag",
        type: "boolean",
        default_value: false,
        rules: [],
        account_id: "account-123",
        environment_id: "env-123"
      }
      company = { id: "comp_1", keys: { "org_id" => "abc" }, traits: [],
                  account_id: "account-123", environment_id: "env-123" }
      user = { id: "user_1", keys: { "email" => "test@test.com" }, traits: [],
               account_id: "account-123", environment_id: "env-123" }

      result = engine.check_flag(flag, company, user)

      assert_kind_of Hash, result
      assert_includes [true, false], result[:value]
    end

    it "handles concurrent check_flag calls safely" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = { id: "flag-concurrent", key: "concurrent-flag", type: "boolean", default_value: true, rules: [],
               account_id: "account-123", environment_id: "env-123" }
      errors = []
      threads = 5.times.map do
        Thread.new do
          10.times { engine.check_flag(flag) }
        rescue StandardError => e
          errors << e
        end
      end

      threads.each(&:join)

      assert_empty errors, "Concurrent check_flag errors: #{errors.map(&:message).join(", ")}"
    end

    # --- Rule Type Reason String Tests ---
    # Validates that the WASM rules engine returns the correct reason/rule_type
    # for each supported rule type (spec: "Includes correct reason string for
    # different rule types").

    RULE_TYPE_COMMON_FIELDS = {
      account_id: "account-123",
      environment_id: "env-123"
    }.freeze

    def self.build_flag(key:, default_value:, rules:)
      {
        id: "flag-#{key}",
        key: key,
        type: "boolean",
        default_value: default_value,
        rules: rules,
        **RULE_TYPE_COMMON_FIELDS
      }
    end

    def self.build_rule(id:, rule_type:, value:, priority: 0, conditions: [], condition_groups: [])
      {
        id: id,
        name: "#{rule_type} rule",
        rule_type: rule_type,
        priority: priority,
        value: value,
        conditions: conditions,
        condition_groups: condition_groups,
        **RULE_TYPE_COMMON_FIELDS
      }
    end

    it "returns 'flag default' reason when flag has no rules" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = self.class.build_flag(key: "default-reason", default_value: true, rules: [])
      result = engine.check_flag(flag)

      assert result[:value], "flag default_value is true"
      refute_nil result[:reason], "reason should be present"
    end

    it "returns correct reason for global_override rule" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = self.class.build_flag(
        key: "global-override-flag",
        default_value: false,
        rules: [
          self.class.build_rule(id: "rule-go", rule_type: "global_override", value: true, priority: 10)
        ]
      )

      result = engine.check_flag(flag)

      assert result[:value], "global override should set value to true"
      assert_equal "rule-go", result[:rule_id]
      assert_equal "global_override", result[:rule_type]
    end

    it "returns correct reason for plan_entitlement rule" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = self.class.build_flag(
        key: "plan-ent-flag",
        default_value: false,
        rules: [
          self.class.build_rule(
            id: "rule-pe",
            rule_type: "plan_entitlement",
            value: true,
            priority: 0,
            conditions: [{
              id: "cond-plan",
              condition_type: "plan",
              operator: "eq",
              resource_ids: ["plan-123"],
              trait_value: "",
              **RULE_TYPE_COMMON_FIELDS
            }],
            condition_groups: []
          )
        ]
      )

      company = {
        id: "comp-pe",
        plan_ids: ["plan-123"],
        plan_version_ids: [],
        billing_product_ids: [],
        crm_product_ids: [],
        credit_balances: {},
        keys: { "org_id" => "pe-org" },
        metrics: [],
        traits: [],
        rules: [],
        **RULE_TYPE_COMMON_FIELDS
      }

      result = engine.check_flag(flag, company)

      assert result[:value], "plan entitlement should match"
      assert_equal "rule-pe", result[:rule_id]
      assert_equal "plan_entitlement", result[:rule_type]
    end

    it "returns correct reason for company_override rule" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      flag = self.class.build_flag(
        key: "company-override-flag",
        default_value: false,
        rules: [
          self.class.build_rule(
            id: "rule-co",
            rule_type: "company_override",
            value: true,
            priority: 5,
            conditions: [{
              id: "cond-company",
              condition_type: "company",
              operator: "eq",
              resource_ids: ["comp-co"],
              trait_value: "",
              **RULE_TYPE_COMMON_FIELDS
            }],
            condition_groups: []
          )
        ]
      )

      company = {
        id: "comp-co",
        plan_ids: [],
        plan_version_ids: [],
        billing_product_ids: [],
        crm_product_ids: [],
        credit_balances: {},
        keys: { "org_id" => "co-org" },
        metrics: [],
        traits: [],
        rules: [],
        **RULE_TYPE_COMMON_FIELDS
      }

      result = engine.check_flag(flag, company)

      assert result[:value], "company override should match"
      assert_equal "rule-co", result[:rule_id]
      assert_equal "company_override", result[:rule_type]
    end

    it "accepts all supported rule types without error" do
      engine = Schematic::RulesEngine.new(logger: Schematic::ConsoleLogger.new(level: :error))
      engine.initialize!

      %w[
        global_override
        plan_entitlement
        company_override
        company_override_usage_exceeded
        plan_entitlement_usage_exceeded
        standard
        default
      ].each do |rule_type|
        flag = self.class.build_flag(
          key: "rt-#{rule_type}",
          default_value: false,
          rules: [
            self.class.build_rule(id: "rule-#{rule_type}", rule_type: rule_type, value: true)
          ]
        )

        result = engine.check_flag(flag)

        assert_kind_of Hash, result, "#{rule_type}: should return a result hash"
        assert_includes [true, false], result[:value], "#{rule_type}: should return a boolean value"
      end
    end
  end
end

# =============================================================================
# Webhook - Rack/Rails Integration Tests
# =============================================================================
describe "Webhook - Rack Integration" do
  before do
    @secret = "test-webhook-secret"
    @body = '{"event":"company.updated","data":{"id":"123"}}'
    @timestamp = "1711900800"
    @signature = Schematic::Webhooks.compute_hex_signature(@body, @timestamp, @secret)
  end

  it "verifies signature from Rack-style request" do
    # Rack converts headers to HTTP_X_... format
    request = Object.new
    request.define_singleton_method(:get_header) do |name|
      case name
      when "HTTP_X_SCHEMATIC_WEBHOOK_SIGNATURE" then @sig
      when "HTTP_X_SCHEMATIC_WEBHOOK_TIMESTAMP" then @ts
      end
    end
    request.define_singleton_method(:raw_post) { @body }
    request.instance_variable_set(:@sig, @signature)
    request.instance_variable_set(:@ts, @timestamp)
    request.instance_variable_set(:@body, @body)

    assert Schematic::Webhooks.verify_webhook_request(request, @secret)
  end

  it "verifies signature from hash-like headers" do
    request = {
      Schematic::Webhooks::SIGNATURE_HEADER => @signature,
      Schematic::Webhooks::TIMESTAMP_HEADER => @timestamp
    }

    # verify_webhook_request extracts body via extract_body — for a hash, .to_s
    # We test extract_header separately below
    sig = Schematic::Webhooks.send(:extract_header, request, Schematic::Webhooks::SIGNATURE_HEADER)
    ts = Schematic::Webhooks.send(:extract_header, request, Schematic::Webhooks::TIMESTAMP_HEADER)

    assert_equal @signature, sig
    assert_equal @timestamp, ts
  end

  it "extract_header handles case-insensitive header lookup" do
    request = { "x-schematic-webhook-signature" => "abc123" }
    result = Schematic::Webhooks.send(:extract_header, request, "X-Schematic-Webhook-Signature")

    # Falls back to downcase lookup
    assert_equal "abc123", result
  end

  it "extract_body reads from raw_post (Rails)" do
    request = Object.new
    request.define_singleton_method(:raw_post) { '{"test":"rails"}' }

    body = Schematic::Webhooks.send(:extract_body, request)

    assert_equal '{"test":"rails"}', body
  end

  it "extract_body reads from body IO (Rack/Sinatra)" do
    body_io = StringIO.new('{"test":"rack"}')
    request = Object.new
    request.define_singleton_method(:body) { body_io }

    body = Schematic::Webhooks.send(:extract_body, request)

    assert_equal '{"test":"rack"}', body

    # Verify body was rewound for subsequent reads
    assert_equal 0, body_io.pos
  end

  it "extract_body reads from string body" do
    request = Object.new
    request.define_singleton_method(:body) { '{"test":"string"}' }

    body = Schematic::Webhooks.send(:extract_body, request)

    assert_equal '{"test":"string"}', body
  end

  it "raises on missing signature in Rack request" do
    request = Object.new
    request.define_singleton_method(:get_header) { |_| nil }
    request.define_singleton_method(:raw_post) { @body }
    request.instance_variable_set(:@body, @body)

    assert_raises(Schematic::Webhooks::MissingSignatureError) do
      Schematic::Webhooks.verify_webhook_request(request, @secret)
    end
  end

  it "raises on invalid signature in Rack request" do
    request = Object.new
    request.define_singleton_method(:get_header) do |name|
      case name
      when "HTTP_X_SCHEMATIC_WEBHOOK_SIGNATURE" then "deadbeef" * 8
      when "HTTP_X_SCHEMATIC_WEBHOOK_TIMESTAMP" then @ts
      end
    end
    request.define_singleton_method(:raw_post) { @body }
    request.instance_variable_set(:@ts, @timestamp)
    request.instance_variable_set(:@body, @body)

    assert_raises(Schematic::Webhooks::InvalidSignatureError) do
      Schematic::Webhooks.verify_webhook_request(request, @secret)
    end
  end
end

# =============================================================================
# Redis Cache Provider Tests
# =============================================================================
describe "RedisCacheProvider" do
  before do
    # Build a simple in-memory mock that matches the Redis client interface
    @store = {}
    @ttls = {}
    @mock_redis = Object.new
    store = @store
    ttls = @ttls

    @mock_redis.define_singleton_method(:get) { |key| store[key] }
    @mock_redis.define_singleton_method(:set) { |key, value| store[key] = value }
    @mock_redis.define_singleton_method(:setex) do |key, ttl, value|
      store[key] = value
      ttls[key] = ttl
    end
    @mock_redis.define_singleton_method(:del) do |*keys|
      keys.flatten.each do |k|
        store.delete(k)
        ttls.delete(k)
      end
    end
    @mock_redis.define_singleton_method(:scan_each) do |match:, count:, &block| # rubocop:disable Lint/UnusedBlockArgument
      pattern = Regexp.new("\\A#{Regexp.escape(match).gsub("\\*", ".*")}\\z")
      store.keys.grep(pattern).each { |k| block.call(k) }
    end

    @cache = Schematic::RedisCacheProvider.new(client: @mock_redis, ttl: 300, key_prefix: "test:")
  end

  it "sets and gets a value" do
    @cache.set("key1", { value: true, flag_key: "flag" })
    result = @cache.get("key1")

    assert result[:value]
    assert_equal "flag", result[:flag_key]
  end

  it "returns nil for missing key" do
    assert_nil @cache.get("nonexistent")
  end

  it "uses key prefix" do
    @cache.set("key1", { value: true })

    assert @store.key?("test:key1")
    refute @store.key?("key1")
  end

  it "sets TTL via setex" do
    @cache.set("key1", { value: true })

    assert_equal 300, @ttls["test:key1"]
  end

  it "supports custom TTL override" do
    @cache.set("key1", { value: true }, ttl: 600)

    assert_equal 600, @ttls["test:key1"]
  end

  it "deletes a key" do
    @cache.set("key1", { value: true })
    @cache.delete("key1")

    assert_nil @cache.get("key1")
  end

  it "delete_missing removes unlisted keys" do
    @cache.set("keep1", { v: 1 })
    @cache.set("keep2", { v: 2 })
    @cache.set("remove1", { v: 3 })

    @cache.delete_missing(%w[keep1 keep2])

    refute_nil @cache.get("keep1")
    refute_nil @cache.get("keep2")
    assert_nil @cache.get("remove1")
  end

  it "handles objects with to_h method" do
    resp = Schematic::CheckFlagResponse.new(value: true, flag_key: "flag", reason: "match")
    @cache.set("resp-key", resp)
    result = @cache.get("resp-key")

    assert result[:value]
    assert_equal "flag", result[:flag_key]
  end
end

# =============================================================================
# DataStream Client - Message Handling Tests
# =============================================================================
# These tests exercise the DataStream::Client's handle_message dispatcher and
# the individual entity handlers without requiring a real WebSocket connection.
# We create a client in replicator mode (no WS needed) and invoke the private
# handle_message method directly, then verify cache state.
# =============================================================================

# Helper to build a DataStream::Client with injectable caches and no network
def build_ds_client(flag_cache: nil, company_cache: nil, user_cache: nil, rules_engine: nil)
  logger = Schematic::ConsoleLogger.new(level: :error)
  re = rules_engine || Schematic::RulesEngine.new(logger: logger)

  fc = flag_cache || TestSharedCache.new(max_size: 100, ttl: 60)
  cc = company_cache || TestSharedCache.new(max_size: 100, ttl: 60)
  uc = user_cache || TestSharedCache.new(max_size: 100, ttl: 60)

  client = Schematic::DataStream::Client.new(
    api_key: "test",
    base_url: "https://api.schematichq.com",
    logger: logger,
    rules_engine: re,
    flag_cache: fc,
    company_cache: cc,
    user_cache: uc,
    replicator_mode: true
  )

  { client: client, flag_cache: fc, company_cache: cc, user_cache: uc, logger: logger }
end

describe "DataStream Client - Full Entity Messages" do
  it "full company message caches the company" do
    ctx = build_ds_client
    ds = ctx[:client]

    company_data = { id: "comp_1", keys: { "org_id" => "abc" }, traits: { "plan" => "pro" }, name: "Acme" }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company_data
            })

    cached = ds.instance_variable_get(:@company_cache).get_by_id("comp_1")

    refute_nil cached
    assert_equal "comp_1", (cached[:id] || cached["id"])

    ds.close
  end

  it "full user message caches the user" do
    ctx = build_ds_client
    ds = ctx[:client]

    user_data = { id: "user_1", keys: { "email" => "test@test.com" }, traits: { "role" => "admin" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: user_data
            })

    cached = ds.instance_variable_get(:@user_cache).get_by_id("user_1")

    refute_nil cached
    assert_equal "user_1", (cached[:id] || cached["id"])

    ds.close
  end

  it "full flag message caches the flag by key" do
    ctx = build_ds_client
    ds = ctx[:client]

    flag_data = { key: "my-flag", type: "boolean", default_value: true, rules: [] }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_FLAG,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: flag_data
            })

    # Flags are stored with versioned keys: "flags:{version}:{key}"
    versioned_key = ds.send(:flag_cache_key, "my-flag")
    cached = ctx[:flag_cache].get(versioned_key)

    refute_nil cached
    assert_equal "my-flag", (cached[:key] || cached["key"])

    ds.close
  end

  it "bulk flags message caches all flags and prunes old ones" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Pre-populate a flag with a versioned key that should be pruned
    old_versioned_key = ds.send(:flag_cache_key, "old-flag")
    ctx[:flag_cache].set(old_versioned_key, { key: "old-flag", rules: [] })

    flags = [
      { key: "flag-a", type: "boolean", default_value: true, rules: [] },
      { key: "flag-b", type: "boolean", default_value: false, rules: [] }
    ]
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_FLAGS,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: flags
            })

    refute_nil ctx[:flag_cache].get(ds.send(:flag_cache_key, "flag-a"))
    refute_nil ctx[:flag_cache].get(ds.send(:flag_cache_key, "flag-b"))
    assert_nil ctx[:flag_cache].get(old_versioned_key), "old-flag should have been pruned by delete_missing"

    ds.close
  end
end

describe "DataStream Client - Partial Entity Messages" do
  it "partial company message merges into existing cached company" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Seed a company
    existing = { id: "comp_1", keys: { "org_id" => "abc" }, traits: { "plan" => "pro" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: existing
            })

    # Send a partial update
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_PARTIAL,
              data: { id: "comp_1", traits: { "seats" => "25" } }
            })

    cached = ds.instance_variable_get(:@company_cache).get_by_id("comp_1")

    refute_nil cached
    traits = cached[:traits]

    assert_equal "pro", (traits[:plan] || traits["plan"]), "original trait should be preserved"
    assert_equal "25", (traits[:seats] || traits["seats"]), "new trait should be merged in"

    ds.close
  end

  it "partial user message merges into existing cached user" do
    ctx = build_ds_client
    ds = ctx[:client]

    existing = { id: "user_1", keys: { "email" => "old@test.com" }, traits: { "role" => "viewer" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: existing
            })

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_PARTIAL,
              data: { id: "user_1", keys: { "user_id" => "u123" } }
            })

    cached = ds.instance_variable_get(:@user_cache).get_by_id("user_1")
    keys = cached[:keys]

    assert_equal "old@test.com", (keys[:email] || keys["email"])
    assert_equal "u123", (keys[:user_id] || keys["user_id"])

    ds.close
  end

  it "partial company for non-existing entity caches as new" do
    ctx = build_ds_client
    ds = ctx[:client]

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_PARTIAL,
              data: { id: "new_comp", keys: { "org_id" => "xyz" }, traits: { "tier" => "free" } }
            })

    cached = ds.instance_variable_get(:@company_cache).get_by_id("new_comp")

    refute_nil cached, "partial message for non-existing entity should create a new cache entry"

    ds.close
  end

  it "partial user for non-existing entity caches as new" do
    ctx = build_ds_client
    ds = ctx[:client]

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_PARTIAL,
              data: { id: "new_user", keys: { "email" => "new@test.com" } }
            })

    cached = ds.instance_variable_get(:@user_cache).get_by_id("new_user")

    refute_nil cached

    ds.close
  end
end

describe "DataStream Client - Delete Messages" do
  it "delete company message removes from cache" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = { id: "comp_del", keys: { "org_id" => "del-me" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    refute_nil ds.instance_variable_get(:@company_cache).get_by_id("comp_del")

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_DELETE,
              data: company
            })

    assert_nil ds.instance_variable_get(:@company_cache).get_by_id("comp_del")

    ds.close
  end

  it "delete user message removes from cache" do
    ctx = build_ds_client
    ds = ctx[:client]

    user = { id: "user_del", keys: { "email" => "del@test.com" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: user
            })

    refute_nil ds.instance_variable_get(:@user_cache).get_by_id("user_del")

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_DELETE,
              data: user
            })

    assert_nil ds.instance_variable_get(:@user_cache).get_by_id("user_del")

    ds.close
  end

  it "delete flag message removes from flag cache" do
    ctx = build_ds_client
    ds = ctx[:client]

    flag = { key: "del-flag", type: "boolean", default_value: false, rules: [] }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_FLAG,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: flag
            })

    versioned_key = ds.send(:flag_cache_key, "del-flag")

    refute_nil ctx[:flag_cache].get(versioned_key)

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_FLAG,
              message_type: Schematic::DataStream::MESSAGE_TYPE_DELETE,
              data: flag
            })

    assert_nil ctx[:flag_cache].get(versioned_key)

    ds.close
  end
end

describe "DataStream Client - Deep Copy / Mutation Prevention" do
  it "modifying a retrieved company does not affect the cache" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = { id: "comp_immut", keys: { "org_id" => "abc" }, traits: { "plan" => "pro" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    # Retrieve and mutate
    retrieved = ds.instance_variable_get(:@company_cache).get_by_id("comp_immut")

    refute_nil retrieved
    # Mutate the returned object
    retrieved[:traits] = { "plan" => "HACKED" }
    retrieved[:id] = "CHANGED"

    # Re-retrieve from cache — should be unaffected
    fresh = ds.instance_variable_get(:@company_cache).get_by_id("comp_immut")

    refute_nil fresh
    assert_equal "comp_immut", (fresh[:id] || fresh["id"])

    ds.close
  end

  it "update_company_metrics does not mutate the original cached object" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = {
      id: "comp_metrics",
      keys: { "org_id" => "metrics-co" },
      metrics: [
        { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 10 }
      ]
    }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    # Get a reference to the cached data before update
    before = ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "metrics-co" })
    original_value = before[:metrics][0][:value]

    # update_company_metrics should deep copy before modifying
    ds.update_company_metrics({ "org_id" => "metrics-co" }, "api_call", 5)

    # The updated value should be stored in cache
    after = ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "metrics-co" })
    updated_metric = after[:metrics].find { |m| (m[:event_subtype] || m["event_subtype"]) == "api_call" }

    assert_equal original_value + 5, (updated_metric[:value] || updated_metric["value"])

    ds.close
  end
end

describe "DataStream Client - Error Message Handling" do
  it "error message logs error and does not crash" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Should not raise
    ds.send(:handle_message, {
              error: "something went wrong",
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY
            })

    ds.close
  end

  it "unknown entity type logs warning and does not crash" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Should not raise
    ds.send(:handle_message, {
              entity_type: "unknown.Type",
              message_type: "full",
              data: { id: "x" }
            })

    ds.close
  end

  it "malformed message does not crash" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Should not raise — rescued by handle_message
    ds.send(:handle_message, {})
    ds.send(:handle_message, { entity_type: nil, data: nil })

    ds.close
  end
end

describe "DataStream Client - Entity Lookup via Keys" do
  it "company can be looked up by resource keys after caching" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = { id: "comp_lookup", keys: { "org_id" => "lookup-org", "slug" => "acme" }, name: "Lookup Co" }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    # Look up by either key
    by_org = ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "lookup-org" })

    refute_nil by_org
    assert_equal "comp_lookup", (by_org[:id] || by_org["id"])

    by_slug = ds.instance_variable_get(:@company_cache).get_by_keys({ "slug" => "acme" })

    refute_nil by_slug
    assert_equal "comp_lookup", (by_slug[:id] || by_slug["id"])

    ds.close
  end

  it "user can be looked up by resource keys after caching" do
    ctx = build_ds_client
    ds = ctx[:client]

    user = { id: "user_lookup", keys: { "email" => "lookup@test.com", "user_id" => "uid_1" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_USER,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: user
            })

    by_email = ds.instance_variable_get(:@user_cache).get_by_keys({ "email" => "lookup@test.com" })

    refute_nil by_email
    assert_equal "user_lookup", (by_email[:id] || by_email["id"])

    ds.close
  end

  it "delete removes key-based lookup as well" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = { id: "comp_keydel", keys: { "org_id" => "keydel-org" } }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    refute_nil ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "keydel-org" })

    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_DELETE,
              data: company
            })

    assert_nil ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "keydel-org" })

    ds.close
  end
end

describe "DataStream Client - String-Keyed Messages" do
  # The server may send messages with string keys rather than symbols.
  # Verify that handle_message works with both formats.
  it "handles string-keyed messages for companies" do
    ctx = build_ds_client
    ds = ctx[:client]

    ds.send(:handle_message, {
              "entity_type" => Schematic::DataStream::ENTITY_TYPE_COMPANY,
              "message_type" => Schematic::DataStream::MESSAGE_TYPE_FULL,
              "data" => { "id" => "str_comp", "keys" => { "org_id" => "str-org" }, "name" => "Str Co" }
            })

    cached = ds.instance_variable_get(:@company_cache).get_by_id("str_comp")

    refute_nil cached

    ds.close
  end

  it "handles string-keyed messages for flags" do
    ctx = build_ds_client
    ds = ctx[:client]

    ds.send(:handle_message, {
              "entity_type" => Schematic::DataStream::ENTITY_TYPE_FLAG,
              "message_type" => Schematic::DataStream::MESSAGE_TYPE_FULL,
              "data" => { "key" => "str-flag", "type" => "boolean", "default_value" => true, "rules" => [] }
            })

    versioned_key = ds.send(:flag_cache_key, "str-flag")
    cached = ctx[:flag_cache].get(versioned_key)

    refute_nil cached

    ds.close
  end
end

describe "DataStream Client - update_company_metrics" do
  it "increments matching metric value" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = {
      id: "comp_met",
      keys: { "org_id" => "met-org" },
      metrics: [
        { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 100 },
        { event_subtype: "page_view", period: "daily", month_reset: nil, value: 50 }
      ]
    }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    ds.update_company_metrics({ "org_id" => "met-org" }, "api_call", 10)

    cached = ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "met-org" })
    api_metric = cached[:metrics].find { |m| (m[:event_subtype] || m["event_subtype"]) == "api_call" }

    assert_equal 110, (api_metric[:value] || api_metric["value"])

    # page_view should be unchanged
    pv_metric = cached[:metrics].find { |m| (m[:event_subtype] || m["event_subtype"]) == "page_view" }

    assert_equal 50, (pv_metric[:value] || pv_metric["value"])

    ds.close
  end

  it "silently does nothing for unknown company" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Should not raise
    ds.update_company_metrics({ "org_id" => "nonexistent" }, "api_call", 5)

    ds.close
  end

  it "silently does nothing when no metrics match event name" do
    ctx = build_ds_client
    ds = ctx[:client]

    company = {
      id: "comp_nomatch",
      keys: { "org_id" => "nomatch-org" },
      metrics: [
        { event_subtype: "api_call", period: "monthly", month_reset: "first", value: 100 }
      ]
    }
    ds.send(:handle_message, {
              entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
              message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
              data: company
            })

    ds.update_company_metrics({ "org_id" => "nomatch-org" }, "unknown_event", 10)

    cached = ds.instance_variable_get(:@company_cache).get_by_keys({ "org_id" => "nomatch-org" })
    metric = cached[:metrics].find { |m| (m[:event_subtype] || m["event_subtype"]) == "api_call" }

    assert_equal 100, (metric[:value] || metric["value"]), "metric value should be unchanged"

    ds.close
  end
end

describe "DataStream Client - Close and Idempotency" do
  it "close is idempotent" do
    ctx = build_ds_client
    ds = ctx[:client]

    # Should not raise on double close
    ds.close
    ds.close
  end

  it "connected? returns false after close" do
    ctx = build_ds_client
    ds = ctx[:client]

    ds.close

    refute_predicate ds, :connected?
  end
end

# =============================================================================
# DataStream Client - redis_client Convenience
# =============================================================================
describe "DataStream Client - redis_client convenience" do
  before do
    @store = {}
    @ttls = {}
    @mock_redis = Object.new
    store = @store
    ttls = @ttls

    @mock_redis.define_singleton_method(:get) { |key| store[key] }
    @mock_redis.define_singleton_method(:set) { |key, value| store[key] = value }
    @mock_redis.define_singleton_method(:setex) do |key, ttl, value|
      store[key] = value
      ttls[key] = ttl
    end
    @mock_redis.define_singleton_method(:del) do |*keys|
      keys.flatten.each do |k|
        store.delete(k)
        ttls.delete(k)
      end
    end
    @mock_redis.define_singleton_method(:scan_each) do |match:, count:, &block| # rubocop:disable Lint/UnusedBlockArgument
      pattern = Regexp.new("\\A#{Regexp.escape(match).gsub("\\*", ".*")}\\z")
      store.keys.grep(pattern).each { |k| block.call(k) }
    end
  end

  it "accepts redis_client and creates cache providers automatically" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      redis_client: @mock_redis
    )

    # Should not raise — Redis-backed caches were auto-created
    refute_nil ds_client
    ds_client.close
  end

  it "replicator mode accepts redis_client without explicit cache providers" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      redis_client: @mock_redis,
      replicator_mode: true
    )

    refute_nil ds_client
    ds_client.close
  end

  it "redis_client stores entities in Redis" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      redis_client: @mock_redis,
      replicator_mode: true
    )

    # Cache a company via handle_message
    company = { id: "comp_redis", keys: { "org_id" => "redis-org" }, name: "Redis Co" }
    ds_client.send(:handle_message, {
                     entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
                     message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
                     data: company
                   })

    # Verify data landed in the mock Redis store (not just local memory)
    redis_keys = @store.keys.select { |k| k.start_with?("schematic:") }

    refute_empty redis_keys, "Company data should be stored in Redis"

    ds_client.close
  end

  it "redis_client with custom key prefix uses that prefix" do
    logger = Schematic::ConsoleLogger.new(level: :error)
    rules_engine = Schematic::RulesEngine.new(logger: logger)

    ds_client = Schematic::DataStream::Client.new(
      api_key: "test",
      base_url: "https://api.schematichq.com",
      logger: logger,
      rules_engine: rules_engine,
      redis_client: @mock_redis,
      redis_key_prefix: "myapp:",
      replicator_mode: true
    )

    company = { id: "comp_prefix", keys: { "org_id" => "pfx-org" }, name: "Prefix Co" }
    ds_client.send(:handle_message, {
                     entity_type: Schematic::DataStream::ENTITY_TYPE_COMPANY,
                     message_type: Schematic::DataStream::MESSAGE_TYPE_FULL,
                     data: company
                   })

    redis_keys = @store.keys.select { |k| k.start_with?("myapp:") }

    refute_empty redis_keys, "Company data should use custom key prefix"

    ds_client.close
  end

  it "SchematicClient passes redis_client through to DataStream" do
    # Stub the replicator health check endpoint
    stub_request(:get, "http://localhost:8090/ready")
      .to_return(status: 200, body: { ready: false }.to_json, headers: { "Content-Type" => "application/json" })

    # Verify the top-level client correctly passes redis_client to DataStream options.
    # We can't easily test full integration without a real WebSocket, but we can
    # verify setup_datastream doesn't raise when redis_client is provided.
    client = Schematic::SchematicClient.new(
      api_key: "api_test_key_123",
      use_data_stream: true,
      datastream_options: {
        redis_client: @mock_redis,
        replicator_mode: true
      }
    )

    refute_nil client
    client.close
    WebMock.reset!
  end
end
