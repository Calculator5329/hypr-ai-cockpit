# Workspace modes

`scripts/workspace-mode` makes a named desktop layout repeatable. Run it from
this repository after Hyprland is running:

```sh
scripts/workspace-mode coding
```

For each app in the selected mode, the script asks `hyprctl clients -j` whether
a matching window already exists. Existing windows are pulled to their defined
monitor and workspace. Missing windows are launched through `hyprctl dispatch
exec`, then the script polls for a matching client for up to 10 seconds before
placing it. Running the same mode again reasserts the placement, so it is safe
to use as a reset shortcut.

## Configure a mode

Edit `config/workspace-modes.json`. A mode has an `apps` list. Every app needs
these fields:

| Field | Meaning |
| --- | --- |
| `match` | A regex string, or an object with `class` and/or `title` regexes, matched against `hyprctl clients -j`. When both object fields are given, both must match. |
| `launch` | Shell command Hyprland runs when no matching window exists. |
| `monitor` | Hyprland monitor ID or name, such as `0`, `1`, or `DP-1`. |
| `workspace` | Optional workspace ID or name for the window. |
| `fullscreen` | Optional boolean. `true` requests fullscreen and `false` turns it off. |

The shipped `coding` mode deliberately uses `YourEditorClass`,
`your-editor-command`, `YourAiChatClass`, and `your-ai-chat-command` as
placeholders. Replace them with the class values and commands for your apps.
Inspect current values with:

```sh
hyprctl clients -j
```

The `tv` and `gaming` examples use generic Firefox/Chromium and Steam matches;
adjust their commands and regexes if you use different applications. Keep a
workspace dedicated to a mode app when you need a strict monitor/workspace
layout, since Hyprland workspaces themselves can be moved between monitors.

Here is a small custom mode shape:

```json
"writing": {
  "apps": [
    {
      "match": { "class": "^(obsidian|Obsidian)$" },
      "launch": "obsidian",
      "monitor": 0,
      "workspace": "writing",
      "fullscreen": false
    }
  ]
}
```

## Suggested Hyprland binds

Add these exact lines to your Hyprland user configuration, updating the
repository path if you installed it elsewhere:

```ini
bind = SUPER, F1, exec, /path/to/hypr-ai-cockpit/scripts/workspace-mode coding
bind = SUPER, F2, exec, /path/to/hypr-ai-cockpit/scripts/workspace-mode tv
bind = SUPER, F3, exec, /path/to/hypr-ai-cockpit/scripts/workspace-mode gaming
```

The script does not need to know how it was triggered. An external voice router
can call the same command (for example, `workspace-mode tv`) for a spoken
desktop-mode shortcut.
