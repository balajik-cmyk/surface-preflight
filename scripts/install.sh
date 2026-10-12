#!/bin/sh
# Copy Surface Preflight into a Cursor repo (skill + always-on commit/push rule).
# Usage: install.sh [dest-repo]
# Dest defaults to the current directory.

set -e

DEST="${1:-.}"
SKILL_ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"

if [ ! -f "$SKILL_ROOT/SKILL.md" ] || [ ! -f "$SKILL_ROOT/reference.md" ] || [ ! -f "$SKILL_ROOT/cursor-rule.mdc" ]; then
  echo "install.sh: missing SKILL.md, reference.md, or cursor-rule.mdc next to scripts/" >&2
  exit 1
fi

if [ ! -d "$DEST" ]; then
  echo "install.sh: destination is not a directory: $DEST" >&2
  exit 1
fi

mkdir -p "$DEST/.cursor/skills/surface-preflight" "$DEST/.cursor/rules"
cp "$SKILL_ROOT/SKILL.md" "$SKILL_ROOT/reference.md" "$DEST/.cursor/skills/surface-preflight/"
cp "$SKILL_ROOT/cursor-rule.mdc" "$DEST/.cursor/rules/surface-preflight.mdc"

echo "Surface Preflight installed in $DEST"
echo "  .cursor/skills/surface-preflight/SKILL.md"
echo "  .cursor/skills/surface-preflight/reference.md"
echo "  .cursor/rules/surface-preflight.mdc"
echo "Commit those files, then say commit in Cursor to check the tables."
