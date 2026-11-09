#!/usr/bin/env sh
# Check links, sync state of both repos, and required tools.
REPO="$(cd "$(dirname "$0")" && pwd)"
TARGET="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
MEM="$HOME/claude-memory"
rc=0

for f in CLAUDE.md settings.json agents commands skills; do
  [ -e "$REPO/$f" ] || continue
  if [ "$(readlink "$TARGET/$f" 2>/dev/null)" = "$REPO/$f" ]; then echo "ok   $TARGET/$f"
  else echo "FAIL $TARGET/$f is not a symlink to $REPO/$f"; rc=1; fi
done

check_repo() {
  [ -d "$1/.git" ] || { echo "FAIL $1 is not a git repo"; rc=1; return; }
  git -C "$1" fetch -q 2>/dev/null
  st="$(git -C "$1" status -sb | head -1)"
  echo "git  $1: $st"
  git -C "$1" status --porcelain | grep -q . && { echo "WARN $1 has uncommitted changes"; rc=1; }
  case "$st" in *behind*|*ahead*) rc=1;; esac
}
check_repo "$REPO"
check_repo "$MEM"

[ "$(git -C "$MEM" config core.hooksPath 2>/dev/null)" = "hooks" ] \
  || { echo "FAIL memory pre-commit hook not enabled"; rc=1; }
command -v gitleaks >/dev/null || { echo "FAIL gitleaks missing: memory commits will be refused"; rc=1; }
[ -n "${CLAUDE_AUTOCOMPACT_PCT_OVERRIDE:-}" ] || echo "WARN CLAUDE_AUTOCOMPACT_PCT_OVERRIDE not exported in this shell (set it in ~/.zshenv)"
exit $rc
