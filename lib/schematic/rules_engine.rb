# frozen_string_literal: true

require "json"

module Schematic
  class RulesEngine
    WASM_PATH = File.join(__dir__, "wasm", "rulesengine.wasm")

    def initialize(logger: nil)
      @logger = logger || ConsoleLogger.new
      @initialized = false
      @mutex = Mutex.new
      @store = nil
      @memory = nil
      @alloc_fn = nil
      @dealloc_fn = nil
      @check_flag_fn = nil
      @get_result_json_fn = nil
      @get_result_json_length_fn = nil
      @get_version_key_fn = nil
    end

    def initialize!
      @mutex.synchronize do
        return if @initialized

        unless File.exist?(WASM_PATH)
          @logger.warn("WASM binary not found at #{WASM_PATH}. Run scripts/download-wasm.sh to fetch it.")
          return
        end

        require "wasmtime"

        engine = Wasmtime::Engine.new
        mod = Wasmtime::Module.from_file(engine, WASM_PATH)

        linker = Wasmtime::Linker.new(engine)

        wasi_config = Wasmtime::WasiConfig.new
        wasi_config.set_stdin_string("")
        @store = Wasmtime::Store.new(engine, wasi_config: wasi_config)

        @instance = linker.instantiate(@store, mod)

        # Get raw WASM exports (C ABI — no wasm-bindgen)
        @memory = @instance.export("memory").to_memory
        @alloc_fn = export_func("alloc")
        @dealloc_fn = export_func("dealloc")
        @check_flag_fn = export_func("checkFlagCombined")
        @get_result_json_fn = export_func("getResultJson")
        @get_result_json_length_fn = export_func("getResultJsonLength")
        @get_version_key_fn = export_func("get_version_key_wasm")

        @initialized = true
        @logger.debug("WASM rules engine initialized")
      rescue LoadError => e
        @logger.warn("wasmtime gem not available, WASM rules engine disabled: #{e.message}")
        @initialized = false
      rescue StandardError => e
        @logger.error("Failed to initialize WASM rules engine: #{e.message}")
        @initialized = false
      end
    end

    def initialized?
      @initialized
    end

    def check_flag(flag, company = nil, user = nil)
      raise "WASM rules engine not initialized" unless @initialized

      # Build combined JSON envelope (same format as Python/C#)
      envelope = { flag: strip_nulls(flag) }
      envelope[:company] = strip_nulls(company) if company
      envelope[:user] = strip_nulls(user) if user

      json_bytes = JSON.generate(envelope).encode("UTF-8")

      @mutex.synchronize do
        ptr = @alloc_fn.call(json_bytes.bytesize)
        begin
          @memory.write(ptr, json_bytes)
          result_len = @check_flag_fn.call(ptr, json_bytes.bytesize)

          raise "WASM checkFlagCombined returned error" if result_len.negative?

          result_ptr = @get_result_json_fn.call
          actual_len = @get_result_json_length_fn.call
          result_json = @memory.read(result_ptr, actual_len).force_encoding("UTF-8")

          normalize_keys(JSON.parse(result_json, symbolize_names: true))
        ensure
          @dealloc_fn.call(ptr, json_bytes.bytesize)
        end
      end
    rescue StandardError => e
      @logger.error("WASM check_flag failed: #{e.message}")
      raise
    end

    def version_key
      raise "WASM rules engine not initialized" unless @initialized

      @mutex.synchronize do
        ptr = @get_version_key_fn.call
        # Read null-terminated string from WASM memory
        raw = @memory.read(ptr, 256)
        null_idx = raw.index("\0") || raw.bytesize
        raw[0, null_idx].force_encoding("UTF-8")
      end
    end

    private

    def export_func(name)
      exp = @instance.export(name)
      raise "WASM export '#{name}' not found" unless exp

      exp.to_func
    end

    # Convert camelCase WASM result keys to snake_case Ruby convention
    def normalize_keys(hash)
      hash.each_with_object({}) do |(k, v), h|
        snake_key = k.to_s.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym
        h[snake_key] = v
      end
    end

    def strip_nulls(obj)
      case obj
      when Hash
        obj.each_with_object({}) do |(k, v), h|
          next if v.nil?

          h[k] = strip_nulls(v)
        end
      when Array
        obj.map { |v| strip_nulls(v) }
      else
        obj
      end
    end
  end
end
