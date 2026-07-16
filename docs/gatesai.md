# GatesAI Chat

GatesAI Chat is an optional cockpit view. It is not bundled with this repo.
Its upstream project is [Calculator5329/gates-ai](https://github.com/Calculator5329/gates-ai),
and releases, when published, are listed at
[github.com/Calculator5329/gates-ai/releases](https://github.com/Calculator5329/gates-ai/releases).

> **TODO(link): release verification required.** The checked-out upstream
> project reports version `0.0.0` and has no usable tagged release metadata.
> Before relying on this guide, publish or identify a signed release asset on
> the [upstream releases page](https://github.com/Calculator5329/gates-ai/releases),
> then replace this notice with its version and asset name.

## Install from a release

Once an upstream release is available:

1. Open the upstream **Releases** page above and select the latest stable
   release for your CPU architecture.
2. Download only an asset published there. If the release provides checksums
   or signatures, verify them before opening the file.
3. Follow the release's installation instructions. For an AppImage, keep the
   downloaded file in a user-controlled applications directory and mark it
   executable; for a native package, use the publisher's documented install
   path.
4. Create a stable local command named `gatesai-chat` that starts the installed
   program. The Hyprland examples below intentionally call that command instead
   of a versioned filename.

Never commit the downloaded binary or a private API credential to this
configuration repository.

## Add the Super+G shortcut

The simple version opens GatesAI directly:

```ini
bind = SUPER, G, exec, gatesai-chat
```

For a cockpit-style resident view, park the application on its own special
workspace. Adapt the class and title after inspecting the installed app with
`hyprctl clients`:

```ini
windowrulev2 = workspace special:gatesai silent, class:^(gatesai-chat)$
windowrulev2 = fullscreen, class:^(gatesai-chat)$
bind = SUPER, G, exec, $HOME/.local/bin/gatesai-toggle
```

`gatesai-toggle` should start `gatesai-chat` if it is not running and otherwise
toggle `special:gatesai` with `hyprctl dispatch togglespecialworkspace gatesai`.
Keeping that logic in a small local script means the keybind stays stable when
the upstream release changes how it launches.

Reload Hyprland after adding the rule and bind:

```sh
hyprctl reload
```

`Super+G` is reserved for GatesAI in the cockpit map; see the complete
[keybind reference](keybinds.md).
