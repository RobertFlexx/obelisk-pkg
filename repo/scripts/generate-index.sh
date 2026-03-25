#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_TOOL_ROOT="${PKG_TOOL_ROOT:-$(cd "$ROOT_DIR/../../opkg" && pwd)}"

if [ ! -x "$PKG_TOOL_ROOT/opkg" ]; then
  echo "Building host opkg helper..."
  (cd "$PKG_TOOL_ROOT" && dub build)
fi

mkdir -p "$ROOT_DIR/packages"
"$PKG_TOOL_ROOT/opkg" repo index "$ROOT_DIR"

# Normalize/sort index for stable commits and diffs.
python3 - "$ROOT_DIR/index.json" <<'PY'
import json
import sys
from pathlib import Path

p = Path(sys.argv[1])
raw = p.read_text(encoding="utf-8")
data = json.loads(raw) if raw.strip() else []
if isinstance(data, list):
    data = sorted(
        data,
        key=lambda x: (
            str(x.get("name", "")),
            str(x.get("ver", "")),
            str(x.get("arch", "")),
            str(x.get("filename", "")),
        ),
    )
p.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
PY

echo "Generated (sorted): $ROOT_DIR/index.json"
