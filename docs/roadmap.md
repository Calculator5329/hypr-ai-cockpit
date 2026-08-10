# hypr-ai-cockpit roadmap

Owner spec (Ethan, 2026-07-16): public shareable version of the Hyprland
AI cockpit. Finance optional/user-supplied. Visibility flip = Ethan-only.

## Now — v1 public package

*(all v1 items below done 2026-07-16 — five lanes + inline README; scrub gate green; main `a23988b`)*

- [x] <!-- workspace:id=work:ac9d90d6-c639-5296-970c-259824e4c007 --> **Port + scrub core Hyprland configs** from `ai-cockpit-setup`
  (`dot_config` → plain `config/` mirroring `~/.config`): hyprland,
  waybar/eww top toolbar, wofi, mako, swaylock, wlogout, GTK. Strip all
  personal tokens (names, hosts, MACs, finance, private project names).
- [x] <!-- workspace:id=work:c419c312-fe85-5af2-b074-cfbb90bd46f2 --> **Top toolbar as shipped feature**: package-installer widget and
  top-right running-localhosts indicator (click → open in browser)
  ported, with a `docs/toolbar.md` explaining each module and how to
  enable/disable them.
- [x] <!-- workspace:id=work:27d5abfd-dafe-5049-999d-8a215c9d45ff --> **install.sh**: backup existing configs → symlink/copy repo
  configs; idempotent; `--dry-run`; Arch/CachyOS package list install
  (pacman + AUR helper) derived from a curated subset of
  `packages/arch-official.txt` / `arch-aur.txt`.
- [x] <!-- workspace:id=work:df4db350-a02d-5b97-a7cc-9d4b24ac3e9f --> **Super-key cheat sheet + keybind reference** (`docs/keybinds.md`
  + an in-desktop cheat-sheet popup bound to a Super chord): includes
  Super+scroll workspace slide, Super+C/B/E/Q chords, finance chord
  marked optional.
- [x] <!-- workspace:id=work:b6286a77-fb20-5964-927f-d171ec8ccb64 --> **Device auto-connect walkthrough** (`docs/devices.md`): pairing
  default audio/bluetooth/displays so they reconnect on login.
- [x] <!-- workspace:id=work:5728fee6-aa02-5a82-90f9-0907479699df --> **AI desktop apps setup** (`docs/ai-tools.md`): Claude Desktop,
  Codex Desktop, Cursor — install scripts/instructions (no bundled
  binaries), plus remote desktop setup.
- [x] <!-- workspace:id=work:ba4b79f5-ec83-5b77-a059-6251b310bd7e --> **GatesAI install + shortcut hookup** (`docs/gatesai.md`): GitHub
  releases download per-OS + wiring the launch shortcut into the
  Super-key scheme.
- [x] <!-- workspace:id=work:b6a4af97-b35b-56fd-bb20-8838647e0ce1 --> **Projects hub for users' own projects** (`docs/projects-hub.md` +
  config): register projects, jump between them from the desktop.
- [x] <!-- workspace:id=work:06cc1a1b-f92b-55f3-8ffb-0c141c466e8b --> **Optional finance module** (`docs/finance-optional.md`): disabled
  by default, placeholder config, user supplies their own data/keys.
- [x] <!-- workspace:id=work:88ae4467-b233-5d65-9333-21388d6f94b3 --> **README diagrams**: Mermaid/SVG of bar layout + workspace flow
  (no real screenshots).
- [x] <!-- workspace:id=work:3ef81db9-0b7a-528f-bfcb-f38d07c45771 --> **Scrub gate** (`docs/scrub-checklist.md` + `tests/verify.sh`):
  automated sweep for personal identifiers; must pass before any push.

## Shipped after v1

- [x] <!-- workspace:id=work:f204d5f4-3dae-5eb6-a3f2-a82a2af41fd4 --> **Workspace-mode engine** (`scripts/workspace-mode`,
  `config/workspace-modes.json`, and `docs/workspace-modes.md`): repeatable
  coding, TV, and gaming layouts that reuse existing windows and launch
  missing apps. (Delivered 2026-07-17 in `f4069a5`; Lua-Hyprland
  compatibility documented in `623495a`.)
- [x] <!-- workspace:id=work:87086104-c5cb-528e-80c9-58f01bd06935 --> **Screenshot/asset pipeline design and owner packet**: capture-time
  privacy invariant, scene manifest, implementation dispatch, and safe
  owner-only capture procedure. (Approved and delivered 2026-07-19 in
  `f9b9f7f`; implementation and sanitized captures remain open below.)

## Next

- [ ] <!-- workspace:id=work:59cec641-5bff-58e2-991d-b10a14ec745a --> Fresh-VM install test (end-to-end `install.sh` on clean CachyOS).
- [x] <!-- workspace:id=work:5ca10614-eede-5a85-97f2-ce133aafaf75 --> [ETHAN] Flip repo public + announce (visibility change is
  owner-only). *(decided 2026-08-01, packet lab brief2: idea dropped — repo
  stays private, no pre-publication sweep needed)*

## Later

- [ ] <!-- workspace:id=work:ba65232d-e7e4-5dfa-823c-5eedd9011b7e --> Implement the approved screenshot/asset pipeline documented under
      `docs/plans/`: land the fail-closed scrub gate, capture the four scenes
      from a sanitized demo profile, record human-approved hashes, and embed
      only those approved images.
- [ ] <!-- workspace:id=work:08face61-67ec-5f40-8560-229ea84239a8 --> Non-Arch distro support (Fedora/openSUSE package maps).
