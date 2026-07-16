# hypr-ai-cockpit roadmap

Owner spec (Ethan, 2026-07-16): public shareable version of the Hyprland
AI cockpit. Finance optional/user-supplied. Visibility flip = Ethan-only.

## Now — v1 public package

- [ ] **Port + scrub core Hyprland configs** from `ai-cockpit-setup`
  (`dot_config` → plain `config/` mirroring `~/.config`): hyprland,
  waybar/eww top toolbar, wofi, mako, swaylock, wlogout, GTK. Strip all
  personal tokens (names, hosts, MACs, finance, private project names).
- [ ] **Top toolbar as shipped feature**: package-installer widget and
  top-right running-localhosts indicator (click → open in browser)
  ported, with a `docs/toolbar.md` explaining each module and how to
  enable/disable them.
- [ ] **install.sh**: backup existing configs → symlink/copy repo
  configs; idempotent; `--dry-run`; Arch/CachyOS package list install
  (pacman + AUR helper) derived from a curated subset of
  `packages/arch-official.txt` / `arch-aur.txt`.
- [ ] **Super-key cheat sheet + keybind reference** (`docs/keybinds.md`
  + an in-desktop cheat-sheet popup bound to a Super chord): includes
  Super+scroll workspace slide, Super+C/B/E/Q chords, finance chord
  marked optional.
- [ ] **Device auto-connect walkthrough** (`docs/devices.md`): pairing
  default audio/bluetooth/displays so they reconnect on login.
- [ ] **AI desktop apps setup** (`docs/ai-tools.md`): Claude Desktop,
  Codex Desktop, Cursor — install scripts/instructions (no bundled
  binaries), plus remote desktop setup.
- [ ] **GatesAI install + shortcut hookup** (`docs/gatesai.md`): GitHub
  releases download per-OS + wiring the launch shortcut into the
  Super-key scheme.
- [ ] **Projects hub for users' own projects** (`docs/projects-hub.md` +
  config): register projects, jump between them from the desktop.
- [ ] **Optional finance module** (`docs/finance-optional.md`): disabled
  by default, placeholder config, user supplies their own data/keys.
- [ ] **README diagrams**: Mermaid/SVG of bar layout + workspace flow
  (no real screenshots).
- [ ] **Scrub gate** (`docs/scrub-checklist.md` + `tests/verify.sh`):
  automated sweep for personal identifiers; must pass before any push.

## Next

- [ ] Fresh-VM install test (end-to-end `install.sh` on clean CachyOS).
- [ ] [ETHAN] Flip repo public + announce (visibility change is
  owner-only).

## Later

- [ ] Screenshot/asset pipeline once Ethan approves captures.
- [ ] Non-Arch distro support (Fedora/openSUSE package maps).
