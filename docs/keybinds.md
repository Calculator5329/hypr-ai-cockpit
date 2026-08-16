# Keybinds

> **Status note, 2026-08-13.** Most of this page describes a design, not the
> shipped configuration. Every `bind` directive this repository ships lives in
> one file, `config/hypr/config/keybinds.conf`, and it defines 43 binds. Rows
> below marked **`NOT SHIPPED`** have no matching bind in that file and do
> nothing after a fresh install. Rows marked **`CONFLICT`** are bound in the
> shipped config to a *different* action than this page states, which is worse
> than absent: following the page gets you the wrong result. Everything
> unmarked was diffed against the config on 2026-08-13 and matches.
>
> Nothing here is a proposal to remove features. The chords are still the
> intended map; the tags say which ones exist today. Added under owner ruling
> S4 `q-batch-notes` = `notes_and_fix` (`doc-truth-packet-20260812`, finding 8).
>
> Not re-measured: whether the named helper applications (`Super+C`, `G`, `H`,
> `P`, the dictation and feedback helpers) are installed on any given machine.
> That is a separate question from whether a chord is bound.

`Super` means the Windows/Meta key. The cockpit is designed around a small
set of memorable Super chords: launch, move, switch, or reveal. Press and
release Super by itself to show the in-desktop hint when that optional helper
is enabled; `Super+Shift+/` opens the searchable bind list. (Neither of those
two is shipped: see the table rows below.)

## Super cheat sheet

| Key | What it does | Shipped? |
| --- | --- | --- |
| `Super+Space` | Open the application launcher | yes |
| `Super+Enter` | Open a terminal | yes |
| `Super+T` | Open a terminal (second binding) | **NOT SHIPPED** |
| `Super+B` | Open the browser | **NOT SHIPPED** |
| `Super+C` | Open Claude Desktop (when installed) | **NOT SHIPPED** |
| `Super+E` | Open the file manager | yes |
| `Super+G` | Summon GatesAI Chat (when configured) | **NOT SHIPPED** |
| `Super+P` | Open the Project Hub (when configured) | **NOT SHIPPED** here — live on Ethan's box via `~/.config/hypr/lua/views.lua` (`project-hub.toggle super-p`) |
| `Super+Q` | Close the focused window | yes |
| `Super+V` | Search clipboard history | **CONFLICT** — bound to *toggle floating* |
| `Super+Scroll` | Slide to the next or previous existing workspace | yes |
| `Super+1` … `Super+0` | Go to workspace 1 … 10 | yes |
| Tap `Super` | Peek at the keybind hint, when the helper is enabled | **NOT SHIPPED** |

The finance-related chords are deliberately optional: `Super+M` can open a
market view, and `Super+Shift+P` can switch a finance module into a
screen-share-safe private display. They do nothing in the default public
configuration. See [Optional finance](finance-optional.md). Confirmed
2026-08-13: neither is bound in `config/hypr/config/keybinds.conf`, which is
exactly what this paragraph already claimed.

## Everyday actions

| Key | Action | Shipped? |
| --- | --- | --- |
| `Super+A` | Ask the configured local AI about the selection or clipboard | **NOT SHIPPED** |
| `Super+Shift+A` | Ask Claude about the selection or clipboard | **NOT SHIPPED** |
| `Super+D` | Toggle push-to-talk dictation | **NOT SHIPPED** |
| `Super+F` | Toggle the feedback helper, if installed | **CONFLICT** — bound to *toggle fullscreen* |
| `Super+N` | Toggle the cockpit dashboard, if installed | **NOT SHIPPED** |
| `Super+I` | Open the communications deck, if configured | **NOT SHIPPED** |
| `Super+Shift+O` | Open the mission/activity log, if configured | **NOT SHIPPED** |
| `Super+Esc` | Open the system monitor | **NOT SHIPPED** |
| `Super+L` | Lock the screen | yes |
| `Super+O` | Reload the top bar | yes |
| `Super+Shift+B` | Show or hide the top bar | **NOT SHIPPED** |
| `Super+W` | Toggle floating for the focused window | **NOT SHIPPED** — floating is on `Super+V` |
| `Super+Shift+F` | Toggle fullscreen for the focused window | **NOT SHIPPED** — fullscreen is on `Super+F` |
| `Super+Shift+S` | Screenshot a region, run OCR, and copy the text | **NOT SHIPPED** |
| `Super+Shift+T` | Add the selection or clipboard to a task helper | **NOT SHIPPED** |
| `Super+Y` | Pin the focused window to every workspace | **NOT SHIPPED** |
| `Super+J` | Toggle the dwindle split orientation | **NOT SHIPPED** |
| `Super+K` | Toggle a Hyprland window group | **NOT SHIPPED** |
| `Super+Tab` | Move to the next window in that group | **NOT SHIPPED** |
| `Super+Alt+G` | Remove window gaps | **NOT SHIPPED** |
| `Super+Alt+Shift+G` | Restore the default window gaps | **NOT SHIPPED** |
| `Super+/` | Open the cockpit tutorial / cheatsheet helper | **NOT SHIPPED** |
| `Super+Shift+/` | Open the searchable all-keybinds popup | **NOT SHIPPED** |

`Super+Shift+M` ends the current graphical session. Treat it as a sign-out
shortcut, not as a window-management key. **NOT SHIPPED:** there is no
`Super+Shift+M` bind in the shipped config, so nothing ends the session today.

## Focus, moving, and sizing windows

| Key | Action | Shipped? |
| --- | --- | --- |
| `Super+←` / `→` / `↑` / `↓` | Focus the window in that direction | yes |
| `Super+Shift+←` / `→` / `↑` / `↓` | Move the focused window in that direction | yes |
| `Super+Drag` | Move a window with the pointer | yes |
| `Super+Right-drag` | Resize a window with the pointer | yes |
| `Super+R` | Enter resize mode | **NOT SHIPPED** |
| Resize mode: arrows or `H` / `J` / `K` / `L` | Resize in that direction | **NOT SHIPPED** — there is no resize submap |
| Resize mode: `Esc` | Leave resize mode | **NOT SHIPPED** — there is no resize submap |
| `Super+Ctrl+Shift` + arrows or `H` / `J` / `K` / `L` | Resize without entering resize mode | **NOT SHIPPED** |

Keyboard resizing is entirely absent from the shipped config. The pointer
bindings above are the only way to resize a window today.

## Workspaces and scratchpads

| Key | Action | Shipped? |
| --- | --- | --- |
| `Super+1` … `Super+0` | Switch to workspace 1 … 10 | yes |
| `Super+Shift+1` … `Super+Shift+0` | Move the focused window to workspace 1 … 10 without following it | yes |
| `Super+Ctrl+1` … `Super+Ctrl+0` | Move the focused window to workspace 1 … 10 and follow it | **NOT SHIPPED** |
| `Super+.` / `Super+,` | Next / previous existing workspace | **NOT SHIPPED** |
| `Super+Scroll down` / `Super+Scroll up` | Next / previous existing workspace | yes |
| `Super+/` | Return to the previously visited workspace | **NOT SHIPPED** — and this page also assigns `Super+/` to the tutorial helper above, so the design itself has not decided |
| `Super+-` | Move the focused window to the general special workspace | **NOT SHIPPED** |
| `Super+=` | Toggle the general special workspace | **NOT SHIPPED** |
| `Super+F1` | Toggle the named scratchpad | **NOT SHIPPED** |
| `Super+Alt+Shift+F1` | Move the focused window to the named scratchpad | **NOT SHIPPED** |

Hyprland only cycles through workspaces that exist, so the scroll gesture
does not create a long trail of empty workspaces. The shipped config does set
`allow_workspace_cycles`, `workspace_back_and_forth`, and `workspace_center_on`
in its `binds { }` block, so the back-and-forth behaviour exists even though no
chord is bound to invoke it directly.

## Screenshots, media, and brightness

| Key | Action | Shipped? |
| --- | --- | --- |
| `Print` | Copy a region screenshot to the clipboard | yes |
| `Ctrl+Print` | Copy the focused-window screenshot to the clipboard | yes |
| `Alt+Print` | Copy the current-display screenshot to the clipboard | yes |
| `Shift+Print` | Save a region screenshot | **NOT SHIPPED** |
| `Ctrl+Shift+Print` | Save a focused-window screenshot | **NOT SHIPPED** |
| `Alt+Shift+Print` | Save a current-display screenshot | **NOT SHIPPED** |
| Audio volume keys | Raise, lower, or mute the default audio output | **NOT SHIPPED** |
| Audio play / next / previous keys | Control the active media player | **NOT SHIPPED** |
| Brightness keys | Raise or lower display brightness | **NOT SHIPPED** |

The three copy-to-clipboard screenshots are shipped; none of the save-to-file
variants is. Media, volume, and brightness keys have no binds at all, so on a
fresh install they fall through to whatever the hardware or another daemon
handles.

## Adjusting the map

The shipped configuration uses Hyprland's `bind` directives. Make changes in
your local Hyprland configuration, keep one action per chord, and reload with
`hyprctl reload`. Before assigning a new Super chord, check this page and the
searchable hint so an existing action is not silently replaced. The searchable
hint is itself unshipped as of 2026-08-13, so until it exists the only complete
list is `config/hypr/config/keybinds.conf` and the `Shipped?` column above.

**Keybind ruling, 2026-08-16 (D1, archive-harvest packet 20260812).**
`Super+P` owns the Project Hub — the live registry and Ethan's 2026-07-12
ruling ("windows H should instead be windows P") agree. Every `Super+H`
Projects-Hub reference in this repo is stale and was reconciled this date;
the old terminal project launcher gets a chord only if it separately earns
one, via the owner-gated global-keybind path.

Application-oriented keys (`C`, `G`, and `P`) intentionally depend on
the optional tools being installed and configured. Their setup guides explain
the matching launch command. Note that this paragraph explains why they might
not *work*; measured 2026-08-13 they are not *bound* either, with or without
the optional tools, so installing the tool alone will not make the chord fire.
