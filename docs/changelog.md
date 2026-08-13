# Changelog


- 2026-08-13 — Tagged `docs/keybinds.md` against the shipped config, per owner
  ruling S4 `q-batch-notes` = `notes_and_fix` (`doc-truth-packet-20260812`,
  finding 8). The page described roughly sixty chords; `config/hypr/config/
  keybinds.conf` is the only bind source and defines 43 binds, most of them the
  workspace numerics. Every table now carries a `Shipped?` column: rows that do
  nothing after a fresh install read `NOT SHIPPED`, and two rows read `CONFLICT`
  because the shipped config binds that chord to a different action than the
  page stated (`Super+V` is toggle-floating, not clipboard history; `Super+F` is
  fullscreen, not the feedback helper). No bind was added, removed, or changed;
  this is a documentation truth pass only.

- 2026-07-26 — Reconciled the public README and roadmap with the shipped
  workspace-mode engine (`f4069a5`, `623495a`) and the approved screenshot
  pipeline plan (`f9b9f7f`). Replaced destructive rejected-capture guidance
  with a private archive/quarantine procedure; pipeline implementation and
  sanitized captures remain explicitly open.
- 2026-07-19 — Screenshot/asset pipeline design approved and documented:
  privacy invariant, scene manifest, implementation dispatch, and owner-only
  sanitized capture packet (`f9b9f7f`).
- 2026-07-17 — Added a declarative workspace-mode engine for repeatable
  coding, TV, and gaming layouts (`f4069a5`), with Lua-Hyprland compatibility
  guidance (`623495a`).
- 2026-07-16 — Repo scaffolded (README, CLAUDE.md, roadmap seeded from
  owner spec, intent recorded in ai-cockpit-setup docs/intent.md).
- 2026-07-16 — v1 public package complete: core configs + toolbar ported
  and scrubbed (33 files), install.sh + curated package lists, six
  walkthrough docs, scrub gate (tests/verify.sh), README with mermaid
  diagrams, MIT license. 4 orchestrator lanes + 1 inline; gate FP on
  gtk ini keys allowlisted narrowly. Pushed main a23988b (private).
