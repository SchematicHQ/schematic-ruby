#!/usr/bin/env ruby
# frozen_string_literal: true

require "webrick"
require "json"
require_relative "../lib/schematic/webhook_verification"

secret = ENV["SCHEMATIC_WEBHOOK_SECRET"] || ARGV[0]
port = (ENV["PORT"] || "8080").to_i

unless secret
  puts "Usage: ruby webhook_test_server.rb <webhook_secret>"
  puts "  or set SCHEMATIC_WEBHOOK_SECRET environment variable"
  exit 1
end

server = WEBrick::HTTPServer.new(Port: port)

server.mount_proc "/webhook" do |req, res|
  puts "\n--- Incoming Webhook ---"
  puts "Method: #{req.request_method}"
  puts "Headers:"
  req.header.each { |k, v| puts "  #{k}: #{v.join(", ")}" }

  body = req.body || ""
  signature = req.header["x-schematic-webhook-signature"]&.first
  timestamp = req.header["x-schematic-webhook-timestamp"]&.first

  begin
    Schematic::Webhooks.verify_signature(body, signature, timestamp, secret)
    puts "\nSignature: VALID"

    begin
      parsed = JSON.pretty_generate(JSON.parse(body))
      puts "Payload:\n#{parsed}"
    rescue JSON::ParserError
      puts "Payload (raw): #{body}"
    end

    res.status = 200
    res.content_type = "application/json"
    res.body = JSON.generate({ status: "ok" })
  rescue Schematic::Webhooks::WebhookSignatureError => e
    puts "\nSignature: INVALID (#{e.message})"
    res.status = 401
    res.content_type = "application/json"
    res.body = JSON.generate({ error: e.message })
  end
end

trap("INT") { server.shutdown }

puts "Webhook test server listening on port #{port}"
puts "POST webhooks to http://localhost:#{port}/webhook"
server.start
