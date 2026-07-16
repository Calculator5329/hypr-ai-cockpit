# hypr-ai-cockpit

A Hyprland desktop built as an **AI development cockpit** — top toolbar with
package installer and live localhost indicator, Super-key chord modes, a
projects hub, and first-class setup for Claude Desktop, Codex Desktop, and
Cursor.

> Status: being prepared for public release. Content is ported and scrubbed
> from a private setup; see `docs/roadmap.md` for what's landing.

## What you get

- **Top toolbar** (Waybar/Eww): time/date/weather/audio, a package
  installer, and a top-right indicator of actively running localhost
  servers — click one to open it in your browser.
- **Super-key workflow**: chord cheat sheet, keybind reference, and
  Super+scroll to slide between workspaces.
- **Projects hub**: register your own projects and jump between them.
- **AI tooling setup**: guided install for Claude Desktop, Codex Desktop,
  Cursor, and remote desktop; GatesAI install + shortcut hookup.
- **Optional finance bar module**: ships disabled; bring your own data.

## Install

```sh
git clone https://github.com/Calculator5329/hypr-ai-cockpit.git
cd hypr-ai-cockpit
./install.sh        # backs up existing configs, then links these in
```

Target platform: Arch/CachyOS with Hyprland. See `docs/` for the full
walkthroughs (device auto-connect, keybinds, AI tools, GatesAI).
