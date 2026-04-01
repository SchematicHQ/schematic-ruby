# frozen_string_literal: true

require "openssl"

module Schematic
  module Webhooks
    SIGNATURE_HEADER = "X-Schematic-Webhook-Signature"
    TIMESTAMP_HEADER = "X-Schematic-Webhook-Timestamp"

    class WebhookSignatureError < StandardError; end
    class MissingSignatureError < WebhookSignatureError; end
    class MissingTimestampError < WebhookSignatureError; end
    class InvalidSignatureError < WebhookSignatureError; end

    module_function

    def compute_signature(body, timestamp, secret)
      body_str = body.is_a?(String) ? body : body.to_s
      message = "#{body_str}+#{timestamp}"
      OpenSSL::HMAC.digest("SHA256", secret, message)
    end

    def compute_hex_signature(body, timestamp, secret)
      compute_signature(body, timestamp, secret).unpack1("H*")
    end

    def verify_signature(payload, signature, timestamp, secret) # rubocop:disable Naming/PredicateMethod
      raise MissingSignatureError, "missing webhook signature" if signature.nil? || signature.empty?
      raise MissingTimestampError, "missing webhook timestamp" if timestamp.nil? || timestamp.empty?

      expected_sig = compute_signature(payload, timestamp, secret)
      provided_sig = [signature].pack("H*")

      raise InvalidSignatureError, "invalid webhook signature" unless secure_compare(expected_sig, provided_sig)

      true
    end

    def verify_webhook_request(request, secret)
      signature = extract_header(request, SIGNATURE_HEADER)
      timestamp = extract_header(request, TIMESTAMP_HEADER)
      body = extract_body(request)

      verify_signature(body, signature, timestamp, secret)
    end

    def secure_compare(expected, actual)
      return false unless expected.bytesize == actual.bytesize

      OpenSSL.fixed_length_secure_compare(expected, actual)
    end

    def extract_header(request, header_name)
      if request.respond_to?(:get_header)
        # Rack-style request
        request.get_header("HTTP_#{header_name.upcase.tr("-", "_")}") ||
          request.get_header(header_name)
      elsif request.respond_to?(:[])
        # Hash-like headers
        request[header_name] ||
          request[header_name.downcase] ||
          request[header_name.upcase.tr("-", "_")]
      end
    end

    def extract_body(request)
      if request.respond_to?(:raw_post)
        request.raw_post
      elsif request.respond_to?(:body)
        body = request.body
        if body.respond_to?(:read)
          content = body.read
          body.rewind if body.respond_to?(:rewind)
          content
        else
          body.to_s
        end
      else
        request.to_s
      end
    end
  end
end
