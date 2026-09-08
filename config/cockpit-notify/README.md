# cockpit-notify

Mirror of the live files (the deployed copies are chezmoi-managed):

| file | deployed at |
|---|---|
| `cockpit-notifyd` | `~/.local/bin/` (autostart in `config/hypr/lua/autostart.lua`) |
| `cockpit-notify` | `~/.local/bin/` |
| `notify-mode` | `~/.local/bin/` (Super+Shift+N cycles all / ai / dnd) |
| `claude-code-hook.py` | `~/.claude/hooks/cockpit-notify-hook.py` (Notification + Stop hooks) |
| `glyphs/*.svg` | `~/.local/share/cockpit-notify/glyphs/` (visions stroke set, tinted per theme) |
| `theme` | `~/.config/cockpit-notify/theme` |

`cockpit-notify --help` documents the card fields. Design: `docs/plans/cockpit-notify-bus-20260908.md`.
