# frozen_string_literal: true

module Schematic
  module DataStream
    class ResourceCache
      CACHE_KEY_PREFIX = "schematic"

      def initialize(primary_cache:, lookup_cache:, key_prefix:, get_id:, get_keys:, cache_version: nil)
        @primary_cache = primary_cache
        @lookup_cache = lookup_cache
        @key_prefix = key_prefix
        @get_id = get_id
        @get_keys = get_keys
        @cache_version = cache_version || ""
      end

      attr_writer :cache_version

      def cache_entity(entity, ttl: nil)
        id = @get_id.call(entity)
        return unless id

        id_key = build_id_key(id)
        @primary_cache.set(id_key, entity, ttl: ttl)

        keys = @get_keys.call(entity)
        keys&.each do |k, v|
          lookup_key = build_lookup_key(k, v)
          @lookup_cache.set(lookup_key, id, ttl: ttl)
        end
      end

      def get_by_id(id)
        id_key = build_id_key(id)
        entity = @primary_cache.get(id_key)
        entity ? Merge.deep_copy(entity) : nil
      end

      def get_by_keys(keys)
        return nil unless keys&.any?

        keys.each do |k, v|
          lookup_key = build_lookup_key(k, v)
          id = @lookup_cache.get(lookup_key)
          if id
            entity = get_by_id(id)
            return entity if entity
          end
        end
        nil
      end

      def delete_entity(entity)
        id = @get_id.call(entity)
        return unless id

        @primary_cache.delete(build_id_key(id))

        keys = @get_keys.call(entity)
        keys&.each do |k, v|
          @lookup_cache.delete(build_lookup_key(k, v))
        end
      end

      private

      def build_id_key(id)
        "#{CACHE_KEY_PREFIX}:#{@key_prefix}:#{@cache_version}:#{id}"
      end

      def build_lookup_key(key_name, key_value)
        "#{CACHE_KEY_PREFIX}:#{@key_prefix}:#{@cache_version}:#{key_name.to_s.downcase}:#{key_value}"
      end
    end
  end
end
