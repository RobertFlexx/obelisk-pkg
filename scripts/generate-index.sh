#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_TOOL_ROOT="${PKG_TOOL_ROOT:-$(cd "$ROOT_DIR/../opkg" && pwd)}"

if [ ! -x "$PKG_TOOL_ROOT/opkg" ]; then
  echo "Building host opkg helper..."
  (cd "$PKG_TOOL_ROOT" && dub build)
fi

mkdir -p "$ROOT_DIR/packages"
"$PKG_TOOL_ROOT/opkg" repo index "$ROOT_DIR"
echo "Generated: $ROOT_DIR/index.json"
