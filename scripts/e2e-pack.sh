#!/bin/bash
set -euo pipefail

# Builds and installs the schematichq gem from the working tree, for the SDK E2E
# harness running with SDK_SOURCE=pack.
#
# `local` mode loads the SDK straight from lib/ and so never exercises packaging:
# the gemspec file list, and the gitignored WASM binary that custom.gemspec.rb
# appends to it. This script builds the real gem, verifies the WASM binary is
# inside it, and installs it, so `ruby testapp/app.rb` resolves the installed gem
# the way an end user would. A gem that would be broken once published fails here
# instead.
#
# Usage (from anywhere):
#   ./scripts/e2e-pack.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

WASM_FILE="lib/schematic/wasm/rulesengine.wasm"
ARTIFACT_DIR="artifacts"
GEM_FILE="$ARTIFACT_DIR/schematichq-e2e.gem"

# --- WASM binary ---

if [ -f "$WASM_FILE" ]; then
    echo "WASM binary already present at $WASM_FILE, skipping download."
else
    echo "WASM binary missing at $WASM_FILE, downloading..."
    ./scripts/download-wasm.sh
fi

if [ ! -f "$WASM_FILE" ]; then
    echo "ERROR: $WASM_FILE still missing after ./scripts/download-wasm.sh"
    exit 1
fi

# --- Build ---

mkdir -p "$ARTIFACT_DIR"
rm -f "$GEM_FILE"
echo "Building gem -> $GEM_FILE"
gem build schematic.gemspec -o "$GEM_FILE"

# --- Verify the WASM binary made it into the gem ---
#
# It is gitignored, so it is in the gem only because custom.gemspec.rb appends it.
# Without it the installed gem cannot run the rules engine.

echo "Verifying $GEM_FILE contains $WASM_FILE..."
GEM_CONTENTS="$(tar -xOf "$GEM_FILE" data.tar.gz | tar -tzf -)"

if ! printf '%s\n' "$GEM_CONTENTS" | grep -qF "$WASM_FILE"; then
    echo "ERROR: $GEM_FILE does not contain $WASM_FILE."
    echo "The published gem would be unable to load the rules engine."
    echo "Check that custom.gemspec.rb still appends the binary, and that"
    echo "$WASM_FILE exists when 'gem build' runs."
    echo "Gem contents:"
    printf '%s\n' "$GEM_CONTENTS"
    exit 1
fi

echo "OK: $WASM_FILE is in the gem."

# --- Install ---

echo "Installing $GEM_FILE..."
gem install --local "$GEM_FILE"

echo "Installing test app dependencies..."
(cd testapp && bundle install)

echo "Done. Run the test app with: SDK_SOURCE=pack ruby testapp/app.rb"
