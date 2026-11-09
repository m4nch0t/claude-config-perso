#!/usr/bin/env sh
# Link this repo into ~/.claude and set up ~/claude-memory. Safe to run many times.
set -eu

REPO="$(cd "$(dirname "$0")" && pwd)"
TARGET="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
MEM="$HOME/claude-memory"
# Set CLAUDE_MEMORY_URL to an empty string to skip the memory clone.
MEM_URL="${CLAUDE_MEMORY_URL-git@github.com:m4nch0t/claude-memory.git}"
mkdir -p "$TARGET"

link() {
  src="$REPO/$1"; dst="$TARGET/$1"
  [ -e "$src" ] || return 0
  if [ -L "$dst" ]; then rm "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "$dst.backup.$(date +%Y%m%d%H%M%S)"; echo "backed up $dst"
  fi
  ln -s "$src" "$dst"; echo "linked $dst -> $src"
}
for f in CLAUDE.md settings.json agents commands skills; do link "$f"; done

# Memory repo: clone if missing, then enable its secret-scanning hook.
if [ ! -d "$MEM/.git" ] && [ -n "$MEM_URL" ]; then
  git clone -q "$MEM_URL" "$MEM" || echo "WARN could not clone $MEM_URL"
fi
if [ -d "$MEM/.git" ]; then
  chmod +x "$MEM/hooks/pre-commit" "$MEM/sync.sh"
  git -C "$MEM" config core.hooksPath hooks
fi

sh "$REPO/doctor.sh" || true
