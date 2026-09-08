# Cockpit notify bus: notifications as a decision surface

Status: proposed 2026-09-08 (Ethan: "do option 1 now, then plan out 3"). Option 1, the
per-source mako restyle with modes, shipped the same day in `config/mako/config`.
This is the plan for option 3.

## What we want

Today a notification is a line of text that disappears. What Ethan actually gets
told about is work finishing (Claude, Codex, lanes), work needing him (owner
packets, approvals, decisions), and things breaking (builds, units, Jarvis
misses). Each of those wants to be *acted on* from the card: focus the window,
open the packet, pick an option, retry. And every one of them should land in a
ledger, because "what did the agents tell me last night" is a query, not a scroll
through mako history.

So: one bus that every source writes to, one card renderer that knows the card
kinds, and buttons that do real, whitelisted things.

## Shape

```
sources ──▶ cockpit-notify (CLI + D-Bus) ──▶ ledger (jsonl)
                                        └──▶ renderer (cards on the Acer, history drawer)
                                                  └──▶ actions (whitelisted commands, inbox answers)
```

### 1. Schema (the data types the cards can carry)

```json
{
  "source":   "claude | codex | jarvis | orchestrator | forge | systemd | chrome | <app-name>",
  "kind":     "info | progress | done | fail | ask",
  "title":    "Lane finished: media-vault faces-ui",
  "body":     "2 commits, tests green, 1 review comment",
  "progress": 0.6,
  "actions":  [{"label": "Open packet", "run": "packet:open <id>"},
               {"label": "Focus window", "run": "hypr:focus address:0x..."},
               {"label": "Approve", "run": "inbox:answer <id> yes"}],
  "link":     "https://forge.local/packets/<id>",
  "image":    "/path/thumb.png",
  "group":    "lane:faces-ui",
  "urgency":  "low | normal | critical",
  "ttl_s":    15
}
```

`run` targets are *names in a registry*, never shell strings. The registry maps
`packet:open`, `hypr:focus`, `inbox:answer`, `project:start`, `jarvis:retry` and
so on to fixed argv. A card cannot run anything else. Same rule as Jarvis:
nothing destructive, and anything consequential is a click on screen.

### 2. `cockpit-notify` CLI

`cockpit-notify --source claude --kind done --title ... --body ... --action "Open packet=packet:open 123"`.
Emits a standard org.freedesktop.Notifications message (so mako or any daemon can
render it today) carrying the schema in hints (`x-cockpit-kind`, `x-cockpit-run`,
the standard `value` hint for progress, `image-path`), and appends the record to
`~/.local/state/cockpit-metrics/notify-YYYY-MM.jsonl`. Every existing script
that calls `notify-send` (jarvis, dictate, context-capture, notify-mode) moves to
it.

### 3. Capture what we do not control

Claude Desktop, Codex and Chrome talk D-Bus directly. A monitor (`busctl monitor`
on the session bus, filtered to `org.freedesktop.Notifications.Notify`) writes
those into the same ledger with `source` = their app-name. That is enough for
phase 1; in phase 2 the renderer *is* the notification server, so it sees them
natively.

### 4. Renderer

Quickshell (QML) on the Acer. Reasons over eww and ags: it ships a
NotificationServer, it is one process, it does layer-shell and per-output
placement cleanly, and QML handles buttons, progress and images without CSS
tricks. Cards:

| kind | looks like | click |
|---|---|---|
| info | one line, source colour | dismiss |
| progress | bar + ETA, replaces itself | dismiss |
| done | title, stat line (commits, tests), source colour | focus window / open packet |
| fail | red rail, last error line, stays | open log / retry |
| ask | question + 2 to 4 option buttons | answers the inbox item |

Plus a history drawer (hold Super+Shift+N, or a Project Hub tab reading the
ledger) grouped by source with unanswered `ask` cards pinned at the top, and the
same three modes as today (all / AI only / dnd).

Design tokens come from `hypr/lua/vars.lua` as the mako restyle does. Flat,
near-opaque panels, 2 px source rail, no gradients, no glass.

### 5. Sources wired

- Jarvis: done/fail cards with "retry" and "show what I heard".
- Claude Code: `Notification` and `Stop` hooks call `cockpit-notify`; a finished
  session is a `done` card with "focus" pointing at the terminal or Claude window.
- Codex desktop: captured by the monitor; later mapped to `done` by title.
- agent-orchestrator: lane finished / failed / needs owner. An owner packet is an
  `ask` card whose buttons answer `agent inbox`. Phone push already exists for the
  same asks; the card is the desktop half.
- systemd user units (`project-*`, whisper-server, forge-shell): `OnFailure=` to
  `cockpit-notify --kind fail`.
- Forge: review outcomes, packet ready.

## Phases and acceptance

1. **Ledger and CLI** (mako keeps rendering). `cockpit-notify` + registry + D-Bus
   monitor + Claude Code hooks + jarvis/dictate/context-capture migrated.
   Acceptance: every notification shown in a day is in the ledger with a source;
   an `ask` sent from the CLI shows buttons in mako and the button answers an
   inbox item.
2. **Cards.** Quickshell renderer replaces mako, all five kinds, history drawer,
   modes. Acceptance: side-by-side screenshots of each kind; card appears under
   50 ms from emit; mako config archived, not deleted.
3. **Decision surface.** Orchestrator asks and Forge packets as `ask` cards;
   answering on the card is the same as answering in the Packets pane; unanswered
   asks survive a reboot (ledger replay). Acceptance: one real owner packet
   answered from a card end to end.

## Questions for Ethan (directional, not method)

- Renderer: quickshell (recommended), ags/astal, or a Chrome tab in the Project
  Hub driven by the ledger? Only the last one has no native buttons.
- Where do cards live: Acer top-right as now, or a dedicated strip along the
  bottom of the HP (the second screen is mostly reference material)?
- Should `ask` cards be able to answer packets at all, or only open them? Today
  the Packets pane is the only place a decision is recorded.
