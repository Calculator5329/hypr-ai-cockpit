# Follow-up task spec — screenshot/asset pipeline (source changes)

This item requires source changes that fall outside this planning lease
(`docs/plans/...`). Dispatch the task below through agent-orchestrator.
It builds the **tooling and the fail-closed gate**; the actual image
capture is an owner action (see [`owner-action-packet.md`]
(owner-action-packet.md)) that must supply the approved PNGs before the
embed step of this task can complete.

There are two ways to run it:

- **Split (recommended):** run Part A now (scripts + gate, no images —
  fully verifiable by an agent), then, after Ethan delivers approved
  PNGs, run Part B (place assets + embed in docs). Part A does not
  depend on Ethan; only Part B does.
- **Single task:** dispatch the whole thing and let it block on the
  owner-action for the PNGs. Prefer the split so Part A isn't idling on
  a human dependency.

---

## Part A — pipeline scripts + verify gate

```yaml
title: "Screenshot asset pipeline — capture/scrub scripts + verify.sh image gate"
goal: >
  Add the maintainer tooling and fail-closed gate for sanitized desktop
  screenshots, per the design.md in this task's plan folder (docs/plans/<task-id>/).
  (1) scripts/capture-assets.sh: for each scene in the manifest, drive grim
      (region via slurp, single-output via -o) into a GITIGNORED staging dir
      under ${XDG_CACHE_HOME:-$HOME/.cache}/hypr-ai-cockpit-assets/raw/ —
      never into the worktree. Idempotent; --list prints scenes; --scene <name>
      captures one.
  (2) scripts/scrub-assets.sh: strip all metadata from each raw
      (oxipng --strip all, or exiftool -all= fallback), optimize
      (oxipng/pngquant), assert dimensions within cap, and print the sha256 of
      each result for pasting into the approval ledger. Degrades gracefully
      when optimizers are absent (warn, don't crash).
  (3) assets/ scaffolding: assets/screenshots/.gitkeep, assets/scenes.tsv
      (from scene-manifest.md), and assets/SCRUB-APPROVED.tsv with a header
      row (sha256<TAB>scene<TAB>date<TAB>reviewer) and no data rows yet.
  (4) .gitignore: ignore the ~/.cache staging path is N/A (outside repo); add
      any in-repo staging safety net if used.
  (5) tests/verify.sh: add an image gate — every tracked raster must live under
      assets/; every image under assets/screenshots/ must have its current
      sha256 in assets/SCRUB-APPROVED.tsv (fail closed on mismatch/missing);
      when exiftool is present, fail on GPS/Artist/Author/HostComputer/user-path
      metadata (skip-with-notice when absent, mirroring the shellcheck pattern);
      fail any tracked image over a 1.5 MB cap. Keep existing checks intact.
  Both scripts pass `shellcheck` and `bash -n`. Do NOT capture or commit any
  real image in this task — the gate is exercised against an empty
  assets/screenshots/ (zero images ⇒ pass) and, optionally, a tiny throwaway
  fixture PNG generated at test time and removed before commit.
owns:
  - scripts/capture-assets.sh
  - scripts/scrub-assets.sh
  - assets/
  - tests/verify.sh
  - .gitignore
  - docs/toolbar.md          # optional: a short "maintainer: capturing assets" note
test-cmd: "bash -n scripts/capture-assets.sh && bash -n scripts/scrub-assets.sh && shellcheck scripts/capture-assets.sh scripts/scrub-assets.sh tests/verify.sh && bash tests/verify.sh"
model-tier: smart
notes: >
  Public repo — every change is world-readable. No personal paths/hosts/names
  in scripts or comments; use ${HOME}/$XDG_CACHE_HOME and documented
  placeholders. verify.sh must still pass its own scrub scan on the new files.
```

## Part B — place approved assets + embed in docs

```yaml
title: "Screenshot asset pipeline — embed approved v1 screenshots in docs"
goal: >
  Precondition: Ethan has delivered the four v1 approved PNGs (top-toolbar,
  wofi-launcher, cheat-sheet, workspace-mode-coding) and appended their
  sha256 rows to assets/SCRUB-APPROVED.tsv per the owner-action packet.
  Place each PNG at assets/screenshots/<scene>.png, embed each in the doc
  location named in scene-manifest.md — ALONGSIDE the existing Mermaid
  diagrams, never replacing them — with descriptive alt text, and update the
  roadmap's diagram-only note if needed (owner-gated). Then run the gate.
owns:
  - assets/screenshots/
  - assets/SCRUB-APPROVED.tsv
  - README.md
  - docs/toolbar.md
  - docs/keybinds.md
  - docs/workspace-modes.md
test-cmd: "bash tests/verify.sh"
model-tier: smart
notes: >
  Blocks on the owner-action packet (approved PNGs + ledger rows). Each
  embedded image MUST have its sha256 in assets/SCRUB-APPROVED.tsv or the gate
  from Part A fails closed. Keep alt text generic (no personal identifiers).
```

---

## Also update (harvesting session / follow-up, not this lease)

- `docs/roadmap.md`: the `CLAUDE.md` "No screenshots of the real desktop
  — diagrams only" rule and the roadmap note should be amended once the
  pipeline lands, to read: *sanitized demo-profile captures only, via the
  scrubbed asset pipeline; no captures of the real desktop.* That edit is
  owner-gated (it changes a standing hard rule) — surface it as a review
  card rather than editing silently.
```
