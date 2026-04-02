# frozen_string_literal: true

def add_custom_gemspec_data(spec)
  spec.homepage = "https://github.com/SchematicHQ/schematic-ruby"

  # The WASM binary is gitignored (downloaded at build time via scripts/download-wasm.sh)
  # but must be included in the published gem. Append it to the file list.
  wasm_file = "lib/schematic/wasm/rulesengine.wasm"
  spec.files << wasm_file if File.exist?(wasm_file) && !spec.files.include?(wasm_file)
end
