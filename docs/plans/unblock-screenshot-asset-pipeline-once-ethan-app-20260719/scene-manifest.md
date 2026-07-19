# Scene manifest

The canonical list of what to capture, how, and where each image lands in
the docs. The follow-up implementation task turns this into a machine-
readable `assets/scenes.tsv` (or keeps it as the source of truth). All
capture commands assume Hyprland is running on the sanitized demo profile
described in [`owner-action-packet.md`](owner-action-packet.md).

`grim` captures the whole focused output; `grim -g "$(slurp)"` captures a
dragged region; `hyprctl activewindow` / `-o <OUTPUT>` scope a single
monitor. Prefer a **single-monitor** grab so a second screen can never
leak in.

## v1 set (gating — ship these four first)

| # | Scene | What must be on screen | Capture recipe | Doc placement |
| --- | --- | --- | --- | --- |
| 1 | `top-toolbar` | Full Waybar: workspaces, clock, local-servers indicator showing 1–2 **dummy** ports, audio, battery, tray, packages, power. | `grim -o <BAR_OUTPUT> -g "<bar-region>"` (crop to the bar strip). | `README.md` "Toolbar layout" — directly under the Mermaid block; `docs/toolbar.md` top. |
| 2 | `wofi-launcher` | Wofi open over a neutral background, generic app list, no recent-file/private entries. | Launch launcher bind, then `grim -o <OUTPUT>`. | `README.md` Features / `docs/keybinds.md`. |
| 3 | `cheat-sheet` | The Super-key cheat-sheet popup showing the chord list. | Trigger cheat-sheet chord, `grim -g "$(slurp)"`. | `docs/keybinds.md` top. |
| 4 | `workspace-mode-coding` | A `workspace-mode coding` layout with **placeholder** editor + AI-chat windows tiled (generic apps standing in for `YourEditorClass`/`YourAiChatClass`). | Run `scripts/workspace-mode coding` with demo apps, `grim -o <OUTPUT>`. | `docs/workspace-modes.md` top; `README.md` "Workspace flow" under the Mermaid block. |

## Later set (queued, non-gating)

| Scene | What | Placement |
| --- | --- | --- |
| `localhost-picker` | Wofi picker when >1 dummy server is running. | `docs/toolbar.md` local-server section. |
| `package-widget` | Package-update widget / terminal it opens. | `docs/toolbar.md` packages row. |
| `projects-hub` | Projects hub with the shipped placeholder projects. | `docs/projects-hub.md`. |
| `mako-notification` | A benign mako notification. | `docs/toolbar.md` or a UX doc. |
| `wlogout` | Wlogout power menu. | `docs/toolbar.md` power row. |
| `full-desktop` | Wide hero shot: bar + wallpaper + one tiled app. | `README.md` top hero. |

## Rules baked into every scene

- Wallpaper: the generic gradient shipped for captures — never a
  personal image.
- Finance module: stays disabled and out of the bar.
- Local-server indicator: only **dummy** servers (`python -m
  http.server 4173` etc.) — never a real dev server on a private port.
- Projects / workspace-mode apps: the shipped placeholder names only.
- No terminal on screen showing a real home path, hostname, or prompt.
- Single monitor per grab unless a scene explicitly needs the multi-
  monitor story (and then only the demo profile's monitors).
```
