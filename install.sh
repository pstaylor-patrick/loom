#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"
SKILLS=("loom-summary")

uninstall() {
  for skill in "${SKILLS[@]}"; do
    local target="$COMMANDS_DIR/${skill}.md"
    if [ -L "$target" ]; then
      rm "$target"
      echo "Removed $target"
    else
      echo "No symlink found for $skill"
    fi
  done
  echo "Uninstall complete."
}

install() {
  mkdir -p "$COMMANDS_DIR"
  for skill in "${SKILLS[@]}"; do
    local source="$SCRIPT_DIR/skills/${skill}/SKILL.md"
    local target="$COMMANDS_DIR/${skill}.md"
    if [ -L "$target" ]; then
      rm "$target"
    fi
    ln -s "$source" "$target"
    echo "Linked $target -> $source"
  done
  echo "Install complete."
}

if [ "${1:-}" = "--uninstall" ]; then
  uninstall
else
  install
fi
