#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

status=0
for recipe in "$ROOT_DIR"/recipes/*.opkrecipe; do
  [ -e "$recipe" ] || continue
  echo "validating: $recipe"
  if ! awk -F= '
    BEGIN { n=0; v=0; s=0; b=0; a=0; ok=1; }
    /^[[:space:]]*#/ { next }
    /^[[:space:]]*$/ { next }
    {
      key=$1;
      val=substr($0, index($0,"=")+1);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", key);
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", val);
      if (key=="name" && val!="") n=1;
      if (key=="version" && val!="") v=1;
      if (key=="summary" && val!="") s=1;
      if (key=="build" && val!="") b=1;
      if (key=="arch" && (val=="x86_64" || val=="noarch")) a=1;
    }
    END {
      if (!n) { print "  missing name"; ok=0; }
      if (!v) { print "  missing version"; ok=0; }
      if (!s) { print "  missing summary"; ok=0; }
      if (!b) { print "  missing build"; ok=0; }
      if (!a) { print "  missing/invalid arch (must be x86_64 or noarch)"; ok=0; }
      exit(ok?0:1);
    }
  ' "$recipe"; then
    status=1
  fi
done

exit "$status"
