# Schematic Ruby SDK

## Architecture

Two-layer SDK:
1. **Fern-generated layer** (`lib/schematic/`) - Auto-generated API client bindings. Do NOT modify directly.
2. **Custom layer** (protected via `.fernignore`) - Hand-written wrapper providing higher-level functionality.

## Key Commands

```bash
# Run all tests (requires Ruby 3.3+)
/opt/homebrew/opt/ruby/bin/ruby -I lib -I test test/custom.test.rb

# Run linter
/opt/homebrew/opt/ruby/bin/bundle exec rubocop

# Run test app
ruby testapp/app.rb

# Download/update WASM binary
./scripts/download-wasm.sh

# Start webhook test server
ruby scripts/webhook_test_server.rb <webhook_secret>
```

## Fern Code Generation

The Fern-generated layer is configured in `schematic-fern-config/fern/generators.yml` (sibling repo). The Ruby SDK uses the `fernapi/fern-ruby-sdk` generator.

Some changes should be configured in the generator config rather than directly as custom code. The  most common example of this is dependencies. Refer to the Fern Ruby SDK generator documentation: https://buildwithfern.com/learn/sdks/generators/ruby/configuration

### Custom Files

All custom files MUST be listed in `.fernignore` to survive Fern regeneration.

## WASM Rules Engine

- Binary: `lib/schematic/wasm/rulesengine.wasm` (gitignored; downloaded at build time)
- Runtime: `wasmtime` gem (required dependency)
- Version pin: `WASM_VERSION` file at repo root
- Download: `./scripts/download-wasm.sh` fetches from internal WASM binary registry
- C ABI exports: `alloc`, `dealloc`, `checkFlagCombined`, `getResultJson`, `getResultJsonLength`, `get_version_key_wasm`
- Input: JSON envelope `{"flag": {...}, "company": {...}, "user": {...}}`
