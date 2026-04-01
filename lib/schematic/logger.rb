# frozen_string_literal: true

module Schematic
  module Logger
    def debug(message, *args)
      raise NotImplementedError
    end

    def info(message, *args)
      raise NotImplementedError
    end

    def warn(message, *args)
      raise NotImplementedError
    end

    def error(message, *args)
      raise NotImplementedError
    end
  end

  class ConsoleLogger
    include Logger

    LEVELS = { debug: 0, info: 1, warn: 2, error: 3 }.freeze

    attr_accessor :level

    def initialize(level: :info)
      @level = level
      @mutex = Mutex.new
      @io = $stderr
    end

    def debug(message, *)
      log(:debug, message, *)
    end

    def info(message, *)
      log(:info, message, *)
    end

    def warn(message, *)
      log(:warn, message, *)
    end

    def error(message, *)
      log(:error, message, *)
    end

    private

    def log(level, message, *args)
      return unless LEVELS.fetch(level, 0) >= LEVELS.fetch(@level, 0)

      formatted = args.empty? ? message : format(message, *args)
      @mutex.synchronize do
        @io.puts("[schematic] [#{level.upcase}] #{formatted}")
      end
    end
  end
end
