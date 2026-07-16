#!/usr/bin/env bash
# A zero count remains visible so the package-installer widget is discoverable.
set -u
count=0
if command -v checkupdates >/dev/null 2>&1; then
  count=$(checkupdates 2>/dev/null | wc -l)
fi
if command -v paru >/dev/null 2>&1; then
  aur=$(paru -Qua 2>/dev/null | wc -l)
  count=$((count + aur))
elif command -v yay >/dev/null 2>&1; then
  aur=$(yay -Qua 2>/dev/null | wc -l)
  count=$((count + aur))
fi
printf '{"text":"%s","tooltip":"%s package update(s); click to install","class":"%s"}\n' "$count" "$count" "$([ "$count" -gt 0 ] && printf updates || printf empty)"

