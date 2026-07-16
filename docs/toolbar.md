# Top toolbar

The shipped toolbar is a single [Waybar](https://github.com/Alexays/Waybar)
bar. It contains no named output, local path, host, account, or private service
configuration.

| Area | Module | What it does |
| --- | --- | --- |
| Left | Workspaces | Displays Hyprland workspaces. Scroll over it to change workspace. |
| Centre | Clock | Shows local time and date; hover for a calendar. |
| Right | Local servers | Lists detected loopback development-server ports. Click to open the only server, or pick one with Wofi when several are running. |
| Right | Audio | Displays output volume; click for `pavucontrol`; scroll to adjust. |
| Right | Battery | Shows charge when a battery is available. |
| Right | Tray | Shows application status icons. |
| Right | Packages | Shows available Arch package updates. Click to open a terminal and run the available `paru`, `yay`, or `pacman` helper. |
| Right | Power | Opens Wlogout. |

## Enable or disable a module

Edit `~/.config/waybar/config` and add or remove its module name from
`modules-left`, `modules-center`, or `modules-right`. Definitions may
remain in the file; a module is inactive until its name appears in one of those
arrays. Reload with `pkill -SIGUSR2 waybar`.

The package widget uses `checkupdates` when installed and includes AUR update
counts when `paru` or `yay` is available. Set `PACMAN_HELPER` before
launching Waybar to use another compatible helper. The package helper presents
its own confirmation and credential prompts; the widget never stores
credentials.

## Local-server indicator

`localhosts.py` checks listening loopback sockets whose owning command looks
like a common web development server. It intentionally ignores remote
addresses. Click the indicator to open the detected host in the default
browser; when more than one server is found it offers a Wofi picker. If Wofi
is unavailable, it opens the first server.

## Optional finance module

`custom/finance` is shipped as code but disabled by default and is not in any
`modules-*` array. `config/waybar/finance.example.json` contains no symbols,
prices, holdings, accounts, or credentials. Keep any personal finance data and
API credentials outside this repository, implement your own local renderer,
then add `custom/finance` to the desired module array.

