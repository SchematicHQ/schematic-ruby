# frozen_string_literal: true

require "json"
require "openssl"

module Schematic
  # Signs the context a browser SDK sends with a publishable key, for
  # environments that require context signatures.
  #
  # A publishable key is public, so the API can't trust the company and user a
  # browser names with it. When the environment requires signatures, your
  # backend, which holds the secret API key, signs the logged-in user's own
  # company and user, and the browser SDK sends that signature in the
  # X-Schematic-Context-Sig header. Sign the context from your own
  # authenticated session, never from what the browser asks for.
  #
  # The signature is `iat.exp.sig`, where `sig` is the unpadded base64url
  # HMAC-SHA256 of `canonical(context).iat.exp` keyed with the secret API key,
  # and `canonical` is the context's JSON with keys sorted by code point and no
  # whitespace.
  module ContextSignature
    # Request header the browser SDK sends the signature in.
    HEADER = "X-Schematic-Context-Sig"

    # How long a signature is valid for unless lifetime_seconds says
    # otherwise. It matches how long the browser SDK reuses one.
    DEFAULT_LIFETIME_SECONDS = 600

    # The longest the API accepts a signature as valid for.
    MAX_LIFETIME_SECONDS = 3600

    # Raised when a context can't be signed.
    class ContextSignatureError < StandardError; end

    module_function

    # Returns the X-Schematic-Context-Sig value for the company and user.
    #
    # secret is the secret API key for the environment the browser SDK's
    # publishable key belongs to. company and user are the logged-in user's
    # keys, as given to the browser SDK; leave one out when it's absent. Keys
    # may be strings or symbols; values must be strings. issued_at is when the
    # signature is valid from, now by default, and lifetime_seconds how long
    # for, from 1 up to MAX_LIFETIME_SECONDS.
    def sign(secret, company: nil, user: nil, lifetime_seconds: DEFAULT_LIFETIME_SECONDS, issued_at: nil)
      raise ContextSignatureError, "lifetime_seconds must be a whole number from 1 to #{MAX_LIFETIME_SECONDS}" unless lifetime_seconds.is_a?(Integer) && lifetime_seconds.between?(1, MAX_LIFETIME_SECONDS)

      iat = (issued_at || Time.now).to_i
      sign_at(secret, iat, iat + lifetime_seconds, company: company, user: user)
    end

    # Signs for an explicit iat and exp, in unix seconds. For tests; use sign.
    # @api private
    def sign_at(secret, iat, exp, company: nil, user: nil)
      raise ContextSignatureError, "a secret API key is required to sign a context" if secret.nil? || secret.empty?

      payload = "#{canonicalize(company: company, user: user)}.#{iat}.#{exp}"
      # Unpadded base64url, without the base64 gem, which Ruby 3.4 stopped
      # bundling by default.
      sig = [OpenSSL::HMAC.digest("SHA256", secret, payload)].pack("m0").tr("+/", "-_").delete("=")
      "#{iat}.#{exp}.#{sig}"
    end

    # Encodes a context the way the API does before verifying it: keys sorted
    # by code point, no whitespace, "<", ">", "&" and "/" left literal, and
    # U+2028 and U+2029 escaped.
    # @api private
    def canonicalize(company: nil, user: nil)
      parts = []
      # "company" sorts before "user".
      parts << "\"company\":#{canonicalize_keys(company)}" unless company.nil?
      parts << "\"user\":#{canonicalize_keys(user)}" unless user.nil?
      "{#{parts.join(",")}}"
    end

    def canonicalize_keys(keys)
      raise ContextSignatureError, "company and user keys must be a hash" unless keys.is_a?(Hash)

      entries = {}
      keys.each do |name, value|
        raise ContextSignatureError, "context key names must be strings or symbols" unless name.is_a?(String) || name.is_a?(Symbol)
        raise ContextSignatureError, "the value of context key #{name.inspect} must be a string" unless value.is_a?(String)

        name = utf8(name.to_s)
        raise ContextSignatureError, "context key #{name.inspect} is given twice" if entries.key?(name)

        entries[name] = utf8(value)
      end

      # String#<=> compares bytes, which for UTF-8 is code point order, the
      # order the API sorts keys in.
      body = entries.keys.sort.map { |name| "#{encode_string(name)}:#{encode_string(entries[name])}" }
      "{#{body.join(",")}}"
    end

    # The API reads each byte of invalid UTF-8 as U+FFFD.
    def utf8(value)
      value = value.dup.force_encoding(Encoding::UTF_8) if value.encoding == Encoding::BINARY
      value = value.encode(Encoding::UTF_8) unless value.encoding == Encoding::UTF_8
      value.scrub("\uFFFD")
    end

    # The stdlib generator escapes quotes, backslashes and control characters
    # the way the API does, and leaves "<", ">", "&" and "/" alone, unlike
    # ActiveSupport's encoder. It leaves U+2028 and U+2029 raw, which the API
    # escapes.
    def encode_string(value)
      JSON.generate(value).gsub("\u2028", "\\u2028").gsub("\u2029", "\\u2029")
    end

    private_class_method :canonicalize_keys, :utf8, :encode_string
  end
end
