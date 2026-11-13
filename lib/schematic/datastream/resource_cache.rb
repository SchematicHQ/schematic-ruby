# frozen_string_literal: true

module Schematic
  module DataStream
    class ResourceCache
      def initialize(primary_cache:, lookup_cache:, key_prefix:, get_id:, get_keys:, cache_version: nil)
        @primary_cache = primary_cache
        @lookup_cache = lookup_cache
        @key_prefix = key_prefix
        @get_id = get_id
        @get_keys = get_keys
        @cache_version = cache_version || ""
      end

      attr_writer :cache_version

      # With keep_ttl, each key keeps its current expiry instead of taking
      # `ttl`, on providers that support it.
      def cache_entity(entity, ttl: nil, keep_ttl: false)
        id = @get_id.call(entity)
        return unless id

        id_key = build_id_key(id)
        write(@primary_cache, id_key, entity, ttl, keep_ttl)

        keys = @get_keys.call(entity)
        keys&.each do |k, v|
          lookup_key = build_lookup_key(k, v)
          write(@lookup_cache, lookup_key, id, ttl, keep_ttl)
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

      def write(cache, key, value, ttl, keep_ttl)
        if keep_ttl && cache.respond_to?(:set_keep_ttl)
          cache.set_keep_ttl(key, value)
        else
          cache.set(key, value, ttl: ttl)
        end
      end

      def build_id_key(id)
        "#{@key_prefix}:#{@cache_version}:#{id}"
      end

      def build_lookup_key(key_name, key_value)
        "#{@key_prefix}:#{@cache_version}:#{key_name.to_s.downcase}:#{key_value.to_s.downcase}"
      end
    end
  end
end
