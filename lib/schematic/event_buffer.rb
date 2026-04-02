# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

module Schematic
  class EventBuffer
    DEFAULT_FLUSH_INTERVAL = 5.0 # seconds (canonical Go value)
    DEFAULT_MAX_BATCH_SIZE = 100
    DEFAULT_MAX_RETRIES = 3
    DEFAULT_INITIAL_RETRY_DELAY = 1.0 # seconds
    JITTER_FACTOR = 0.25
    DEFAULT_CAPTURE_BASE_URL = "https://c.schematichq.com"

    def initialize(api_key:, logger:, interval: DEFAULT_FLUSH_INTERVAL, max_batch_size: DEFAULT_MAX_BATCH_SIZE,
                   offline: false, capture_base_url: DEFAULT_CAPTURE_BASE_URL)
      @api_key = api_key
      @logger = logger
      @interval = interval
      @max_batch_size = max_batch_size
      @offline = offline
      @capture_url = URI.parse("#{capture_base_url}/batch")
      @events = []
      @mutex = Mutex.new
      @stopped = false
      @flushing = false
      @flush_done = ConditionVariable.new

      start_periodic_flush unless @offline
    end

    def push(event)
      return if @offline

      should_flush = false
      @mutex.synchronize do
        return if @stopped

        @events << event
        should_flush = @events.size >= @max_batch_size
      end

      flush if should_flush
    end

    def flush
      events_to_send = nil
      did_set_flushing = false
      @mutex.synchronize do
        return if @flushing || @events.empty?

        @flushing = true
        did_set_flushing = true
        events_to_send = @events.dup
        @events.clear
      end

      return unless events_to_send&.any?

      send_batch(events_to_send)

      # Events may have accumulated while we were sending. Drain them so
      # a size-triggered flush that lost the race doesn't have to wait for
      # the next periodic interval.
      drain_pending
    ensure
      if did_set_flushing
        @mutex.synchronize do
          @flushing = false
          @flush_done.broadcast
        end
      end
    end

    def stop
      @mutex.synchronize do
        @stopped = true

        # Wait for any in-flight flush to complete before our final flush,
        # so we don't skip events that arrived during the in-flight batch.
        @flush_done.wait(@mutex, 30) if @flushing
      end

      flush

      @flush_thread&.join(5)
    end

    private

    def start_periodic_flush
      @flush_thread = Thread.new do
        loop do
          sleep(@interval)
          break if @stopped

          begin
            flush
          rescue StandardError => e
            @logger.error("Event flush error: #{e.message}")
          end
        end
      end
      @flush_thread.abort_on_exception = false
    end

    def drain_pending
      events_to_send = @mutex.synchronize do
        return if @events.empty?

        batch = @events.dup
        @events.clear
        batch
      end

      send_batch(events_to_send) if events_to_send&.any?
    end

    def send_batch(events)
      payload = {
        events: events.map { |e| event_to_capture_payload(e) }
      }

      attempts = 0
      while attempts <= DEFAULT_MAX_RETRIES
        begin
          post_to_capture_service(payload)
          @logger.debug("Flushed #{events.size} events to capture service")
          return
        rescue StandardError => e
          attempts += 1
          if attempts > DEFAULT_MAX_RETRIES
            @logger.error("Failed to send event batch after #{DEFAULT_MAX_RETRIES} retries: #{e.message}")
            return
          end

          delay = calculate_backoff(attempts - 1)
          @logger.warn("Event batch send failed (attempt #{attempts}/#{DEFAULT_MAX_RETRIES}), retrying in #{delay.round(2)}s: #{e.message}")
          sleep(delay)
        end
      end
    end

    def post_to_capture_service(payload)
      http = Net::HTTP.new(@capture_url.host, @capture_url.port)
      http.use_ssl = @capture_url.scheme == "https"
      http.open_timeout = 10
      http.read_timeout = 10

      request = Net::HTTP::Post.new(@capture_url.path)
      request["Content-Type"] = "application/json"
      request["X-Schematic-Api-Key"] = @api_key
      request.body = JSON.generate(payload)

      response = http.request(request)
      return if response.is_a?(Net::HTTPSuccess)

      raise "capture service returned #{response.code}: #{response.body}"
    end

    def calculate_backoff(attempt)
      base_delay = DEFAULT_INITIAL_RETRY_DELAY * (2**attempt)
      jitter = base_delay * JITTER_FACTOR * ((rand * 2) - 1) # ±25%
      base_delay + jitter
    end

    # Transform to capture service payload format (differs from Fern API):
    # - Field is `type` not `event_type`
    # - Each event includes `api_key`
    def event_to_capture_payload(event)
      {
        api_key: @api_key,
        type: event[:event_type],
        body: event[:body],
        sent_at: event[:sent_at] || Time.now.utc.iso8601
      }
    end
  end
end
