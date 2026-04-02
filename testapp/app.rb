#!/usr/bin/env ruby
# frozen_string_literal: true

##
# SDK E2E Test App for schematic-ruby.
#
# A lightweight HTTP server implementing the standard test app contract
# defined in the SDK spec. The E2E harness (SchematicHQ/actions/sdk-e2e)
# calls POST /configure after startup to pass an env-scoped API key,
# then runs assertions against the other endpoints.
#
# SDK source is controlled by SDK_SOURCE env var:
#   - "local" (default): loads from ../lib
#   - "published": requires the 'schematichq' gem from RubyGems
#
# Usage:
#   # Local build (default)
#   ruby testapp/app.rb
#
#   # Published version
#   cd testapp && bundle install
#   SDK_SOURCE=published ruby app.rb

require "webrick"
require "json"
require "socket"

# --- SDK Loading ---

$LOAD_PATH.unshift(File.join(__dir__, "..", "lib")) unless ENV["SDK_SOURCE"] == "published"
require "schematichq"

# --- Constants ---

PORT = Integer(ENV["PORT"] || "8080")
CACHE_TTL = 2.0 # Short TTL for E2E -- tests sleep past this to verify cache expiration
CACHE_TTL_MS = (CACHE_TTL * 1000).to_i

# --- State ---

module AppState
  class << self
    attr_accessor :client, :current_config, :cache_providers
  end

  self.client = nil
  self.current_config = {}
  self.cache_providers = nil
end

# --- Helpers ---

def parse_json(request)
  body = request.body
  return {} if body.nil? || body.empty?

  JSON.parse(body)
end

def json_response(response, status, body)
  response.status = status
  response["Content-Type"] = "application/json"
  response.body = JSON.generate(body)
end

# --- Route handlers ---

def handle_health(_request, response)
  cfg = AppState.current_config
  json_response(response, 200,
                "status" => AppState.client ? "configured" : "waiting",
                "config" => {
                  "offline" => cfg["offline"] || false,
                  "useDataStream" => cfg["useDataStream"] || false,
                  "hasFlagDefaults" => cfg["flagDefaults"].is_a?(Hash) && !cfg["flagDefaults"].empty?,
                  "cacheTtlMs" => CACHE_TTL_MS
                })
end

def handle_configure(request, response)
  config = parse_json(request)

  # Close existing client if any
  begin
    AppState.client&.close
  rescue StandardError
    # ignore close errors
  end

  opts = {
    api_key: config["apiKey"]
  }

  # Cache provider: disabled or SDK defaults with short TTL
  cache_providers = if config["noCache"]
                      []
                    else
                      [Schematic::LocalCache.new(ttl: CACHE_TTL)]
                    end
  opts[:cache_providers] = cache_providers
  AppState.cache_providers = cache_providers

  opts[:base_url] = config["baseUrl"] if config["baseUrl"]
  opts[:event_capture_base_url] = config["eventCaptureBaseUrl"] if config["eventCaptureBaseUrl"]
  opts[:flag_defaults] = config["flagDefaults"] if config["flagDefaults"]
  opts[:offline] = true if config["offline"]

  if config["useDataStream"]
    opts[:use_data_stream] = true

    datastream_opts = { cache_ttl: CACHE_TTL }

    if config["replicatorUrl"]
      datastream_opts[:replicator_mode] = true
      datastream_opts[:replicator_health_url] = "#{config["replicatorUrl"]}/ready"
    end

    opts[:datastream_options] = datastream_opts
  end

  opts[:log_level] = :debug
  AppState.client = Schematic::SchematicClient.new(**opts)
  AppState.current_config = config

  json_response(response, 200, "success" => true, "cacheTtlMs" => CACHE_TTL_MS)
end

def handle_check_flag(request, response)
  unless AppState.client
    json_response(response, 503, "error" => "not configured")
    return
  end

  body = parse_json(request)

  begin
    value = AppState.client.check_flag(body["flagKey"], company: body["company"], user: body["user"])
    json_response(response, 200, "value" => value)
  rescue StandardError => e
    json_response(response, 200, "value" => false, "error" => e.message)
  end
end

def handle_check_flag_with_entitlement(request, response)
  unless AppState.client
    json_response(response, 503, "error" => "not configured")
    return
  end

  body = parse_json(request)

  begin
    resp = AppState.client.check_flag_with_entitlement(body["flagKey"], company: body["company"], user: body["user"])
    json_response(response, 200, resp.to_h.transform_keys(&:to_s))
  rescue StandardError => e
    json_response(response, 200, "value" => false, "error" => e.message)
  end
end

def handle_identify(request, response)
  unless AppState.client
    json_response(response, 503, "error" => "not configured")
    return
  end

  body = parse_json(request)

  # Translate E2E contract to Ruby SDK's identify body:
  #   E2E:  { "company": {k:v}, "user": {k:v}, "keys": {k:v} }
  #   SDK:  { keys: {k:v}, company: { keys: {k:v} } }
  identify_body = { keys: body["keys"] || body["user"] || {} }
  identify_body[:company] = { keys: body["company"] } if body["company"]

  begin
    AppState.client.identify(identify_body)
    json_response(response, 200, "success" => true)
  rescue StandardError => e
    json_response(response, 200, "success" => false, "error" => e.message)
  end
end

def handle_track(request, response)
  unless AppState.client
    json_response(response, 503, "error" => "not configured")
    return
  end

  body = parse_json(request)

  track_body = { event: body["event"] }
  track_body[:company] = body["company"] if body["company"]
  track_body[:user] = body["user"] if body["user"]
  track_body[:traits] = body["traits"] if body["traits"]
  track_body[:quantity] = body["quantity"] unless body["quantity"].nil?

  begin
    AppState.client.track(track_body)
    json_response(response, 200, "success" => true)
  rescue StandardError => e
    json_response(response, 200, "success" => false, "error" => e.message)
  end
end

def handle_set_flag_default(request, response)
  unless AppState.client
    json_response(response, 503, "error" => "not configured")
    return
  end

  body = parse_json(request)

  begin
    AppState.client.set_flag_default(body["flagKey"], body["value"])
    json_response(response, 200, "success" => true)
  rescue StandardError => e
    json_response(response, 200, "success" => false, "error" => e.message)
  end
end

def handle_config(_request, response)
  cfg = AppState.current_config
  json_response(response, 200,
                "apiKey" => cfg["apiKey"] ? "#{cfg["apiKey"][0..6]}..." : nil,
                "offline" => cfg["offline"] || false,
                "useDataStream" => cfg["useDataStream"] || false,
                "flagDefaults" => cfg["flagDefaults"] || {},
                "cacheTtlMs" => CACHE_TTL_MS,
                "configured" => !AppState.client.nil?)
end

# --- Port finder ---

def find_available_port(start_port)
  port = start_port
  loop do
    server = TCPServer.new("0.0.0.0", port)
    server.close
    return port
  rescue Errno::EADDRINUSE
    warn "Port #{port} in use, trying #{port + 1}..."
    port += 1
  end
end

# --- Server ---

port = find_available_port(PORT)

server = WEBrick::HTTPServer.new(
  Port: port,
  Logger: WEBrick::Log.new($stderr, WEBrick::Log::INFO),
  AccessLog: [[File.open(File::NULL, "w"), WEBrick::AccessLog::COMMON_LOG_FORMAT]]
)

server.mount_proc("/health") { |req, res| handle_health(req, res) }

server.mount_proc "/configure" do |req, res|
  req.request_method == "POST" ? handle_configure(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc "/check-flag" do |req, res|
  req.request_method == "POST" ? handle_check_flag(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc "/check-flag-with-entitlement" do |req, res|
  req.request_method == "POST" ? handle_check_flag_with_entitlement(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc "/identify" do |req, res|
  req.request_method == "POST" ? handle_identify(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc "/track" do |req, res|
  req.request_method == "POST" ? handle_track(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc "/set-flag-default" do |req, res|
  req.request_method == "POST" ? handle_set_flag_default(req, res) : json_response(res, 405, "error" => "method not allowed")
end

server.mount_proc("/config") { |req, res| handle_config(req, res) }

$stdout.puts "SDK E2E test app listening on http://localhost:#{port}"
$stdout.puts "Waiting for POST /configure to initialize SchematicClient..."
$stdout.flush

# Graceful shutdown
shutdown = proc do
  warn "\nShutting down..."
  AppState.client&.close
rescue StandardError
  nil
ensure
  server.shutdown
end

trap("INT", &shutdown)
trap("TERM", &shutdown)

server.start
