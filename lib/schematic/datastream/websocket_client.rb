# frozen_string_literal: true

require "socket"
require "openssl"
require "uri"
require "json"
require "websocket"

module Schematic
  module DataStream
    WRITE_WAIT = 10       # seconds
    PONG_WAIT = 60        # seconds
    PING_PERIOD = 54      # seconds (PONG_WAIT * 9/10)
    MAX_RECONNECT_ATTEMPTS = 10
    MIN_RECONNECT_DELAY = 1  # seconds
    MAX_RECONNECT_DELAY = 30 # seconds

    ENTITY_TYPE_COMPANY = "rulesengine.Company"
    ENTITY_TYPE_COMPANIES = "rulesengine.Companies"
    ENTITY_TYPE_USER = "rulesengine.User"
    ENTITY_TYPE_USERS = "rulesengine.Users"
    ENTITY_TYPE_FLAG = "rulesengine.Flag"
    ENTITY_TYPE_FLAGS = "rulesengine.Flags"

    MESSAGE_TYPE_FULL = "full"
    MESSAGE_TYPE_PARTIAL = "partial"
    MESSAGE_TYPE_DELETE = "delete"
    MESSAGE_TYPE_ERROR = "error"

    class WebSocketClient
      attr_reader :url, :connected, :ready

      def initialize(base_url:, api_key:, logger:, message_handler:, ready_handler: nil)
        @base_url = base_url
        @api_key = api_key
        @logger = logger
        @message_handler = message_handler
        @ready_handler = ready_handler
        @connected = false
        @ready = false
        @should_reconnect = true
        @reconnect_attempts = 0
        @mutex = Mutex.new
        @write_mutex = Mutex.new
        @connect_mutex = Mutex.new
        @connecting = false
        @socket = nil
        @read_thread = nil
        @ping_thread = nil
        @stopped = false
        @url = build_ws_url(base_url)
        @last_pong = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      end

      def start
        @should_reconnect = true
        Thread.new { connect }
      end

      def close
        @mutex.synchronize do
          @should_reconnect = false
          @stopped = true
          @connected = false
          @ready = false
        end

        close_socket
        @ping_thread&.join(5)
        @read_thread&.join(5)
      end

      def send_message(data)
        return unless @connected

        msg = JSON.generate(data)
        write_frame(:text, msg)
      rescue StandardError => e
        @logger.error("WebSocket send error: #{e.message}")
      end

      private

      def build_ws_url(base_url)
        uri = URI.parse(base_url)
        scheme = uri.scheme == "https" ? "wss" : "ws"
        host = uri.host

        # Replace 'api' subdomain with 'datastream'
        host = host.sub(/\Aapi\./, "datastream.") if host&.start_with?("api.")

        port = uri.port
        port_str = if (scheme == "wss" && port == 443) || (scheme == "ws" && port == 80) || port.nil?
                     ""
                   else
                     ":#{port}"
                   end

        "#{scheme}://#{host}#{port_str}/datastream"
      end

      def connect
        return if @stopped

        # Guard against concurrent connect attempts — if another thread is
        # already connecting, skip this call rather than opening a parallel
        # connection.
        @connect_mutex.synchronize do
          return if @connecting

          @connecting = true
        end

        begin
          uri = URI.parse(@url)
          tcp = TCPSocket.new(uri.host, uri.port || (uri.scheme == "wss" ? 443 : 80))
          tcp.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

          if uri.scheme == "wss"
            ctx = OpenSSL::SSL::SSLContext.new
            ctx.verify_mode = OpenSSL::SSL::VERIFY_PEER
            ctx.cert_store = OpenSSL::X509::Store.new.tap(&:set_default_paths)
            ssl = OpenSSL::SSL::SSLSocket.new(tcp, ctx)
            ssl.hostname = uri.host
            ssl.connect
            @socket = ssl
          else
            @socket = tcp
          end
          @tcp_socket = tcp

          perform_handshake

          @mutex.synchronize do
            @connected = true
            @reconnect_attempts = 0
          end
          @logger.info("DataStream connected to #{@url}")

          start_read_loop
          start_ping_loop

          @ready_handler&.call
          @mutex.synchronize { @ready = true }
        rescue StandardError => e
          @logger.error("DataStream connection failed: #{e.message}")
          close_socket
          schedule_reconnect
        ensure
          @connect_mutex.synchronize { @connecting = false }
        end
      end

      def perform_handshake
        @handshake = WebSocket::Handshake::Client.new(
          url: @url,
          headers: { "X-Schematic-Api-Key" => @api_key }
        )

        @socket.write(@handshake.to_s)

        loop do
          chunk = @socket.readpartial(4096)
          raise "Connection closed during handshake" unless chunk && !chunk.empty?

          @handshake << chunk
          break if @handshake.finished?
        end

        raise "WebSocket handshake failed: #{@handshake.error}" unless @handshake.valid?

        @ws_version = @handshake.version
      end

      def start_read_loop
        @frame_parser = WebSocket::Frame::Incoming::Server.new(version: @ws_version)

        @read_thread = Thread.new do
          loop do
            break if @stopped

            begin
              data = @socket.readpartial(4096)
              unless data && !data.empty?
                @logger.info("DataStream connection closed by server")
                break
              end

              @frame_parser << data

              while (frame = @frame_parser.next)
                case frame.type
                when :text, :binary
                  handle_text_message(frame.data)
                when :ping
                  write_frame(:pong, frame.data)
                when :pong
                  @last_pong = Process.clock_gettime(Process::CLOCK_MONOTONIC)
                when :close
                  @logger.info("DataStream received close frame")
                  break
                end
              end
            rescue IOError, Errno::ECONNRESET, OpenSSL::SSL::SSLError => e
              @logger.warn("DataStream read error: #{e.message}")
              break
            rescue StandardError => e
              @logger.error("DataStream unexpected error: #{e.message}")
              break
            end
          end

          handle_disconnect
        end
        @read_thread.abort_on_exception = false
      end

      def start_ping_loop
        @last_pong = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @ping_thread = Thread.new do
          loop do
            sleep(PING_PERIOD)
            break if @stopped || !@connected

            # Check if we've received a pong within PONG_WAIT
            elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - @last_pong
            if elapsed > PONG_WAIT
              @logger.warn("Pong timeout (#{elapsed.round(1)}s > #{PONG_WAIT}s), closing connection")
              close_socket
              break
            end

            begin
              write_frame(:ping, "")
            rescue StandardError => e
              @logger.warn("Ping failed: #{e.message}")
              break
            end
          end
        end
        @ping_thread.abort_on_exception = false
      end

      def handle_text_message(data)
        message = JSON.parse(data, symbolize_names: true)
        @message_handler.call(message)
      rescue JSON::ParserError => e
        @logger.error("Failed to parse DataStream message: #{e.message}")
      rescue StandardError => e
        @logger.error("Error handling DataStream message: #{e.message}")
      end

      def handle_disconnect
        was_connected = @connected
        @mutex.synchronize do
          @connected = false
          @ready = false
        end

        @logger.info("DataStream disconnected") if was_connected

        schedule_reconnect if @should_reconnect
      end

      def schedule_reconnect
        return unless @should_reconnect
        return if @stopped

        @reconnect_attempts += 1
        if @reconnect_attempts > MAX_RECONNECT_ATTEMPTS
          @logger.error("DataStream max reconnection attempts (#{MAX_RECONNECT_ATTEMPTS}) reached")
          return
        end

        delay = [MIN_RECONNECT_DELAY * (2**(@reconnect_attempts - 1)), MAX_RECONNECT_DELAY].min
        jitter = rand * [delay * 0.25, 1.0].max
        total_delay = delay + jitter

        @logger.info("DataStream reconnecting in #{total_delay.round(1)}s (attempt #{@reconnect_attempts}/#{MAX_RECONNECT_ATTEMPTS})")

        Thread.new do
          sleep(total_delay)
          connect unless @stopped
        end
      end

      def close_socket
        @socket&.close
      rescue IOError
        # Already closed
      ensure
        # When using TLS, @socket is the SSL wrapper and @tcp_socket is the
        # underlying TCP connection. Close both to avoid leaking file descriptors.
        if @tcp_socket && @tcp_socket != @socket
          begin
            @tcp_socket.close
          rescue IOError
            # Already closed
          end
        end
        @socket = nil
        @tcp_socket = nil
      end

      def write_frame(type, data)
        frame = WebSocket::Frame::Outgoing::Client.new(
          version: @ws_version || 13,
          type: type,
          data: data
        )
        @write_mutex.synchronize { @socket&.write(frame.to_s) }
      end
    end
  end
end
