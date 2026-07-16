#!/usr/bin/env bash
# Run by the Waybar package widget. The helper asks for confirmation itself.
set -euo pipefail
if [[ -n "${PACMAN_HELPER:-}" ]]; then
  helper=$PACMAN_HELPER
elif command -v paru >/dev/null 2>&1; then
  helper=paru
elif command -v yay >/dev/null 2>&1; then
  helper=yay
elif command -v pacman >/dev/null 2>&1; then
  helper=pacman
else
  printf 'No Arch package helper found. Install pacman, paru, or yay first.\n' >&2
  exit 1
fi
printf 'Running %s -Syu. Confirm changes in the package helper.\n' "$helper"
exec "$helper" -Syu

