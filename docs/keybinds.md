# Keybinds

`Super` means the Windows/Meta key. The cockpit is designed around a small
set of memorable Super chords: launch, move, switch, or reveal. Press and
release Super by itself to show the in-desktop hint when that optional helper
is enabled; `Super+Shift+/` opens the searchable bind list.

## Super cheat sheet

| Key | What it does |
| --- | --- |
| `Super+Space` | Open the application launcher |
| `Super+Enter` or `Super+T` | Open a terminal |
| `Super+B` | Open the browser |
| `Super+C` | Open Claude Desktop (when installed) |
| `Super+E` | Open the file manager |
| `Super+G` | Summon GatesAI Chat (when configured) |
| `Super+H` | Open the Projects Hub (when configured) |
| `Super+P` | Choose a registered project / terminal session |
| `Super+Q` | Close the focused window |
| `Super+V` | Search clipboard history |
| `Super+Scroll` | Slide to the next or previous existing workspace |
| `Super+1` … `Super+0` | Go to workspace 1 … 10 |
| Tap `Super` | Peek at the keybind hint, when the helper is enabled |

The finance-related chords are deliberately optional: `Super+M` can open a
market view, and `Super+Shift+P` can switch a finance module into a
screen-share-safe private display. They do nothing in the default public
configuration. See [Optional finance](finance-optional.md).

## Everyday actions

| Key | Action |
| --- | --- |
| `Super+A` | Ask the configured local AI about the selection or clipboard |
| `Super+Shift+A` | Ask Claude about the selection or clipboard |
| `Super+D` | Toggle push-to-talk dictation |
| `Super+F` | Toggle the feedback helper, if installed |
| `Super+N` | Toggle the cockpit dashboard, if installed |
| `Super+I` | Open the communications deck, if configured |
| `Super+Shift+O` | Open the mission/activity log, if configured |
| `Super+Esc` | Open the system monitor |
| `Super+L` | Lock the screen |
| `Super+O` | Reload the top bar |
| `Super+Shift+B` | Show or hide the top bar |
| `Super+W` | Toggle floating for the focused window |
| `Super+Shift+F` | Toggle fullscreen for the focused window |
| `Super+Shift+S` | Screenshot a region, run OCR, and copy the text |
| `Super+Shift+T` | Add the selection or clipboard to a task helper |
| `Super+Y` | Pin the focused window to every workspace |
| `Super+J` | Toggle the dwindle split orientation |
| `Super+K` | Toggle a Hyprland window group |
| `Super+Tab` | Move to the next window in that group |
| `Super+Alt+G` | Remove window gaps |
| `Super+Alt+Shift+G` | Restore the default window gaps |
| `Super+/` | Open the cockpit tutorial / cheatsheet helper |
| `Super+Shift+/` | Open the searchable all-keybinds popup |

`Super+Shift+M` ends the current graphical session. Treat it as a sign-out
shortcut, not as a window-management key.

## Focus, moving, and sizing windows

| Key | Action |
| --- | --- |
| `Super+←` / `→` / `↑` / `↓` | Focus the window in that direction |
| `Super+Shift+←` / `→` / `↑` / `↓` | Move the focused window in that direction |
| `Super+Drag` | Move a window with the pointer |
| `Super+Right-drag` | Resize a window with the pointer |
| `Super+R` | Enter resize mode |
| Resize mode: arrows or `H` / `J` / `K` / `L` | Resize in that direction |
| Resize mode: `Esc` | Leave resize mode |
| `Super+Ctrl+Shift` + arrows or `H` / `J` / `K` / `L` | Resize without entering resize mode |

## Workspaces and scratchpads

| Key | Action |
| --- | --- |
| `Super+1` … `Super+0` | Switch to workspace 1 … 10 |
| `Super+Shift+1` … `Super+Shift+0` | Move the focused window to workspace 1 … 10 without following it |
| `Super+Ctrl+1` … `Super+Ctrl+0` | Move the focused window to workspace 1 … 10 and follow it |
| `Super+.` / `Super+,` | Next / previous existing workspace |
| `Super+Scroll down` / `Super+Scroll up` | Next / previous existing workspace |
| `Super+/` | Return to the previously visited workspace |
| `Super+-` | Move the focused window to the general special workspace |
| `Super+=` | Toggle the general special workspace |
| `Super+F1` | Toggle the named scratchpad |
| `Super+Alt+Shift+F1` | Move the focused window to the named scratchpad |

Hyprland only cycles through workspaces that exist, so the scroll gesture
does not create a long trail of empty workspaces.

## Screenshots, media, and brightness

| Key | Action |
| --- | --- |
| `Print` | Copy a region screenshot to the clipboard |
| `Ctrl+Print` | Copy the focused-window screenshot to the clipboard |
| `Alt+Print` | Copy the current-display screenshot to the clipboard |
| `Shift+Print` | Save a region screenshot |
| `Ctrl+Shift+Print` | Save a focused-window screenshot |
| `Alt+Shift+Print` | Save a current-display screenshot |
| Audio volume keys | Raise, lower, or mute the default audio output |
| Audio play / next / previous keys | Control the active media player |
| Brightness keys | Raise or lower display brightness |

## Adjusting the map

The shipped configuration uses Hyprland's `bind` directives. Make changes in
your local Hyprland configuration, keep one action per chord, and reload with
`hyprctl reload`. Before assigning a new Super chord, check this page and the
searchable hint so an existing action is not silently replaced.

Application-oriented keys (`C`, `G`, `H`, and `P`) intentionally depend on
the optional tools being installed and configured. Their setup guides explain
the matching launch command.
