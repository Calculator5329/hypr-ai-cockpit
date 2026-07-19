# Design — screenshot / asset pipeline

Roadmap item (Later): **"Screenshot/asset pipeline once Ethan approves
captures."** — `docs/roadmap.md`. Ethan's decision: **APPROVED**
(2026-07-19). This design unblocks the item; it is a plan, not source
changes. All source work is specified in [`DISPATCH.md`](DISPATCH.md);
the capture itself is an owner action, specified in
[`owner-action-packet.md`](owner-action-packet.md).

## The one hard constraint this design exists to satisfy

The repo `CLAUDE.md` carries a standing rule from 2026-07-16: *"No
screenshots of the real desktop — diagrams only."* Ethan's APPROVED
decision lifts the blanket ban **for a sanitized capture pipeline**, not
for ad-hoc screenshots of his actual machine. The whole pipeline is
therefore built around a single invariant:

> **Every committed image is a capture of a throwaway demo profile that
> never contained personal data, and every image is metadata-scrubbed
> and human-approved before it is tracked.**

This is defence in depth, not a single check, because a raster image
cannot be `git grep`-ed the way text can. The scrub gate that guards
this repo today (`tests/verify.sh`) reads text; it is blind to a
username baked into a titlebar or a private project name in a file
picker. So the pipeline moves the guarantee **left**, to capture time:
if the environment being photographed never held anything personal,
there is nothing to leak, and the post-capture checks only have to prove
that property held.

## Layer-4 framing

- **Verb served:** *illustrate* — give a prospective user an accurate
  visual of the cockpit without exposing the owner's machine.
- **Consumes:** a running Hyprland session on a sanitized demo profile;
  the shipped configs in `config/`; the scene list in
  [`scene-manifest.md`](scene-manifest.md).
- **Emits:** optimized, metadata-stripped PNGs under `assets/`; a
  signed approval ledger; README/doc embeds that sit *alongside* the
  existing Mermaid diagrams (the diagrams stay — they are the fallback
  and the "how it flows" view; screenshots are the "what it looks like"
  view).
- **v1 shipped when:** the four scenes in the manifest's "v1" set are
  captured, scrubbed, approved, embedded, and `tests/verify.sh` passes
  with the new image gate active.

## Why a demo profile instead of blur/redaction

Three candidate approaches were considered:

1. **Photograph the real desktop, then blur/crop personal regions.**
   Rejected. It is the failure mode the 2026-07-16 rule was written
   against: one missed titlebar, tooltip, or notification ships a
   hostname to a public repo forever. Redaction is a manual, all-or-
   nothing filter with no fail-closed check.
2. **Fully synthetic mockups (Figma / HTML-to-PNG of the bar).**
   Rejected for v1. High effort, and it drifts from reality — a mockup
   of Waybar is not evidence the shipped `config/waybar` actually
   renders. Kept as a *later* option for hero art only.
3. **Capture a sanitized demo profile.** Chosen. A fresh throwaway user
   account (or the fresh-VM from the adjacent "Fresh-VM install test"
   roadmap item) runs `install.sh`, populates the placeholder projects
   and a generic wallpaper, and is photographed. Nothing personal was
   ever on screen, so the post-capture gate is a confirmation, not a
   rescue.

Approach 3 also composes with the existing "Fresh-VM install test" item:
the same clean VM that proves `install.sh` works is the correct place to
shoot from, so the two items can share one owner session.

## Pipeline stages

```
 (1) prepare        (2) capture         (3) scrub          (4) approve        (5) embed
 demo profile  -->  grim per scene  -->  strip metadata --> human review  -->  optimize + place
 (owner/VM)         (staging, gitig-     + optimize        + ledger sign      under assets/,
                     nored ~/.cache)     (oxipng/exiftool) (sha256 recorded)  wire into docs
                                                                              + verify.sh gate
```

1. **Prepare** — sanitized environment (see owner-action packet). Demo
   projects use the placeholder names already shipped in
   `config/projects` / `config/workspace-modes.json`; wallpaper is a
   generic gradient shipped for this purpose; finance module stays
   disabled; no real localhost servers with private ports (use a dummy
   `python -m http.server` on a couple of ports so the indicator has
   something benign to show).
2. **Capture** — `scripts/capture-assets.sh` drives `grim` (full or
   region via `slurp`) once per scene defined in the manifest. Output
   lands in a **gitignored staging dir** (`${XDG_CACHE_HOME:-~/.cache}/
   hypr-ai-cockpit-assets/raw/`), never the worktree, so a half-scrubbed
   raw can never be committed by reflex.
3. **Scrub** — `scripts/scrub-assets.sh` runs each raw through
   `oxipng --strip all` (or `exiftool -all=`) to remove PNG text chunks,
   timestamps, and any color-profile/EXIF metadata, then `pngquant`/
   `oxipng` for size. It also asserts pixel dimensions are within a cap
   (no accidental multi-monitor grab that pulls in a second screen).
4. **Approve** — the human opens each scrubbed candidate, confirms no
   personal data is visible, and records approval in
   `assets/SCRUB-APPROVED.tsv` (one row per image: `sha256  scene  date
   reviewer`). This ledger is the fail-closed contract: an image whose
   current sha256 is not in the ledger is treated as unapproved.
5. **Embed** — approved PNGs move to `assets/screenshots/<scene>.png`;
   docs embed them next to the relevant Mermaid diagram / section.

## verify.sh gate (added by the follow-up task)

`tests/verify.sh` gains an image gate that runs on every checkout and
must pass before release:

- **Location:** every tracked raster (`*.png`/`*.jpg`/`*.jpeg`/`*.webp`)
  must live under `assets/`. Fail otherwise — stops stray screenshots
  dropped into `docs/` or repo root.
- **Approval:** every tracked image under `assets/screenshots/` must
  have its current `sha256` present in `assets/SCRUB-APPROVED.tsv`.
  Edit an image without re-approving → hash mismatch → fail closed.
- **Metadata (best-effort):** when `exiftool` is available, fail if any
  image carries GPS, `Artist`, `Author`, `HostComputer`, or a user-path
  string in a text chunk. Skipped-with-notice when `exiftool` is absent
  (mirrors the existing `shellcheck` optional-tool pattern) — the human
  approval step and capture-time `--strip all` are the primary guard;
  this is the automated backstop.
- **Size:** fail any tracked image over a byte cap (e.g. 1.5 MB) to keep
  the public repo lean and to flag un-optimized commits.

This keeps the guarantee mechanical: the gate cannot read what is *in* a
picture, but it can prove that every picture was scrubbed of metadata,
was signed off by a human, and hasn't changed since.

## Scope boundary for v1

Ship the **four** highest-value scenes only (manifest "v1" set):
top toolbar, Wofi launcher, keybind cheat-sheet, workspace-mode layout.
The remaining scenes are queued but not gating. Mermaid diagrams stay in
place — screenshots augment, never replace them, so the docs still read
correctly on a checkout that predates the captured assets.

## Risks & mitigations

| Risk | Mitigation |
| --- | --- |
| Personal data in a corner of a capture | Demo profile (nothing personal ever on screen) + human ledger sign-off + metadata scrub. |
| Un-optimized PNGs bloat a public repo | Byte-cap gate in verify.sh; `oxipng`/`pngquant` in scrub stage. |
| Images drift from shipped config over time | Manifest records the exact scene + command; re-capture is a re-run, not guesswork. Diagrams remain as the always-true fallback. |
| Capture tooling absent on a contributor box | Capture/scrub scripts are owner/maintainer tools, not part of `install.sh`; verify.sh image checks degrade gracefully when `exiftool` is missing. |
| Someone commits a raw straight from the desktop | Staging dir is gitignored and lives in `~/.cache`, outside the worktree; verify.sh rejects images outside `assets/`. |
```
