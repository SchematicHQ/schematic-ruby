# frozen_string_literal: true

module Schematic
  module CacheProvider
    def get(key)
      raise NotImplementedError
    end

    def set(key, value, ttl: nil)
      raise NotImplementedError
    end

    def delete(key)
      raise NotImplementedError
    end

    # Remove all keys matching `scope` that are NOT in `keys_to_keep`.
    # `scope:` is required so shared caches (e.g. Redis) only prune their own
    # namespace instead of wiping sibling caches that share a base key_prefix.
    def delete_missing(keys_to_keep, scope:)
      raise NotImplementedError
    end
  end

  class LocalCache
    include CacheProvider

    DEFAULT_MAX_SIZE = 1000
    DEFAULT_TTL = 5.0 # seconds

    def initialize(max_size: DEFAULT_MAX_SIZE, ttl: DEFAULT_TTL)
      @max_size = max_size
      @ttl = ttl
      # Ruby's Hash maintains insertion order, so we use it as an ordered map.
      # Re-inserting a key moves it to the end, giving us O(1) LRU touch.
      @cache = {} # key => CacheEntry (insertion order = LRU order)
      @mutex = Mutex.new
      @stopped = false

      start_cleanup if @max_size.positive? && @ttl.positive?
    end

    def get(key)
      @mutex.synchronize do
        entry = @cache[key]
        return nil unless entry

        if entry.expired?
          @cache.delete(key)
          return nil
        end
        touch(key)
        entry.value
      end
    end

    def set(key, value, ttl: nil)
      @mutex.synchronize do
        effective_ttl = ttl || @ttl
        return if @max_size <= 0

        if @cache.key?(key)
          @cache.delete(key)
          @cache[key] = CacheEntry.new(value, effective_ttl)
        else
          evict_lru while @cache.size >= @max_size
          @cache[key] = CacheEntry.new(value, effective_ttl)
        end
      end
    end

    def delete(key)
      @mutex.synchronize do
        @cache.delete(key)
      end
    end

    def delete_missing(keys_to_keep, scope:)
      keep_set = keys_to_keep.to_set
      @mutex.synchronize do
        @cache.delete_if { |k, _| k.start_with?(scope) && !keep_set.include?(k) }
      end
    end

    def size
      @mutex.synchronize { @cache.size }
    end

    def stop
      @mutex.synchronize { @stopped = true }
    end

    private

    # O(1) touch: delete + re-insert moves key to end of ordered Hash
    def touch(key)
      entry = @cache.delete(key)
      @cache[key] = entry if entry
    end

    def evict_lru
      oldest_key, = @cache.first
      @cache.delete(oldest_key) if oldest_key
    end

    def start_cleanup
      cleanup_interval = (@ttl / 4.0).clamp(1.0, 60.0)
      @cleanup_thread = Thread.new do
        loop do
          sleep(cleanup_interval)
          break if @stopped

          @mutex.synchronize do
            @cache.delete_if { |_, entry| entry.expired? }
          end
        end
      end
      @cleanup_thread.abort_on_exception = false
    end

    # :nodoc:
    class CacheEntry
      attr_reader :value, :ttl, :created_at

      def initialize(value, ttl)
        @value = value
        @ttl = ttl
        @created_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end

      def expired?
        Process.clock_gettime(Process::CLOCK_MONOTONIC) - created_at > ttl
      end
    end
  end
end
