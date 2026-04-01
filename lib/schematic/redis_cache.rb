# frozen_string_literal: true

require "json"

module Schematic
  # Minimal interface describing the Redis client methods used by RedisCacheProvider.
  # Compatible with the 'redis' gem's Redis client.
  module RedisClientInterface
    def get(key)
      raise NotImplementedError
    end

    def setex(key, seconds, value)
      raise NotImplementedError
    end

    def set(key, value)
      raise NotImplementedError
    end

    def del(*keys)
      raise NotImplementedError
    end

    def scan_each(match:, count:, &block)
      raise NotImplementedError
    end
  end

  class RedisCacheProvider
    include CacheProvider

    DEFAULT_TTL = 5 # seconds
    DEFAULT_KEY_PREFIX = "schematic:"
    BATCH_DELETE_SIZE = 1000

    def initialize(client:, ttl: DEFAULT_TTL, key_prefix: DEFAULT_KEY_PREFIX)
      @client = client
      @default_ttl = ttl
      @key_prefix = key_prefix
    end

    def get(key)
      full_key = prefixed_key(key)
      value = @client.get(full_key)
      return nil if value.nil?

      JSON.parse(value, symbolize_names: true)
    rescue JSON::ParserError
      nil
    end

    def set(key, value, ttl: nil)
      full_key = prefixed_key(key)
      serialized = JSON.generate(value.respond_to?(:to_h) ? value.to_h : value)
      actual_ttl = ttl || @default_ttl

      if actual_ttl.positive?
        @client.setex(full_key, actual_ttl.to_i, serialized)
      else
        @client.set(full_key, serialized)
      end
    end

    def delete(key)
      full_key = prefixed_key(key)
      @client.del(full_key)
    end

    def delete_missing(keys_to_keep)
      full_keys_to_keep = keys_to_keep.to_set { |k| prefixed_key(k) }
      keys_to_delete = []

      @client.scan_each(match: "#{@key_prefix}*", count: BATCH_DELETE_SIZE) do |key|
        unless full_keys_to_keep.include?(key)
          keys_to_delete << key

          if keys_to_delete.size >= BATCH_DELETE_SIZE
            @client.del(*keys_to_delete)
            keys_to_delete.clear
          end
        end
      end

      @client.del(*keys_to_delete) if keys_to_delete.any?
    end

    private

    def prefixed_key(key)
      "#{@key_prefix}#{key}"
    end
  end
end
