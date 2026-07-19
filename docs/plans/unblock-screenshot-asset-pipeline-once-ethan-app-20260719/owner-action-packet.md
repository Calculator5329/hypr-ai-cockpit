# Owner-action packet — capture the v1 screenshots

**Why an agent cannot do this:** capturing requires a running Hyprland
display session. This lane runs headless in a git worktree with no
display, and — critically — the only environment with a real desktop is
your machine, which must never be photographed for a public repo. The
capture must happen on a **sanitized demo profile** that only you can
stand up. Part A of [`DISPATCH.md`](DISPATCH.md) (the scripts + gate) is
fully agent-doable and does not need you; this packet is only the image
capture that feeds Part B.

Run this **after** Part A has landed (so `scripts/capture-assets.sh`,
`scripts/scrub-assets.sh`, and `assets/SCRUB-APPROVED.tsv` exist).

## What it changes

Produces four scrubbed PNGs and four rows in
`assets/SCRUB-APPROVED.tsv`. Nothing is published until Part B embeds
them and `tests/verify.sh` passes.

## Where to run it

Best: the clean CachyOS VM from the "Fresh-VM install test" roadmap item
— one session covers both. Otherwise: a throwaway local user account
that has never held personal data. **Not your real desktop.**

## Steps

1. **Stand up the demo profile.** In the clean VM / throwaway user:
   ```sh
   git clone https://github.com/Calculator5329/hypr-ai-cockpit.git
   cd hypr-ai-cockpit
   ./install.sh
   ```
   Then, inside that Hyprland session:
   - set the generic gradient wallpaper (not a personal image);
   - leave the finance module disabled (default);
   - start 1–2 dummy servers so the localhost indicator has benign
     content: `python -m http.server 4173 &` (and `5173` for the picker
     shot);
   - register the shipped placeholder projects only; use generic apps
     for the `workspace-mode coding` demo (stand-ins for
     `YourEditorClass` / `YourAiChatClass`).

2. **Capture** the four v1 scenes (see
   [`scene-manifest.md`](scene-manifest.md) for exact framing):
   ```sh
   scripts/capture-assets.sh --list          # confirm scene names
   scripts/capture-assets.sh --scene top-toolbar
   scripts/capture-assets.sh --scene wofi-launcher
   scripts/capture-assets.sh --scene cheat-sheet
   scripts/capture-assets.sh --scene workspace-mode-coding
   ```
   Raws land in `~/.cache/hypr-ai-cockpit-assets/raw/` (gitignored,
   outside the repo).

3. **Scrub + optimize:**
   ```sh
   scripts/scrub-assets.sh                    # strips metadata, optimizes
   ```
   It prints a `sha256  scene` line per output image.

4. **Review each scrubbed image with your own eyes.** Open all four.
   Confirm: no hostname, username, home path, real project name, finance
   data, personal wallpaper, tooltip, or notification is visible in any
   corner. If one is contaminated, delete it and re-shoot — do **not**
   try to blur it.

5. **Sign the ledger.** For each image you approved, append one
   tab-separated row to `assets/SCRUB-APPROVED.tsv`:
   ```
   <sha256-from-step-3>	<scene>	2026-07-19	<your-handle>
   ```
   (Use the date you approve; reviewer is your own handle.)

6. **Hand the approved PNGs + the updated ledger back** to the Part B
   task (or copy them into the repo's `assets/screenshots/` and the
   ledger, then dispatch Part B to do the doc embeds).

## Expected success

`scrub-assets.sh` prints four sha256 lines with no metadata warnings;
after you add the ledger rows and place the PNGs, `bash tests/verify.sh`
prints `Verification passed.`

## Undo / safety

Fully reversible until commit: raws live in `~/.cache` and can be
deleted (`rm -rf ~/.cache/hypr-ai-cockpit-assets`); un-embedded PNGs and
ledger rows can be removed with no trace. Once published to the public
repo an image is world-readable and effectively permanent — hence the
demo-profile + eyes-on-every-image gate before that point. If any doubt
about a capture, discard it; a missing screenshot is harmless (the
Mermaid diagram still carries the doc), a leaked one is not.

## What to return so automation resumes

Either the four approved PNGs + the four ledger rows, or a note that you
placed them in `assets/screenshots/` + `assets/SCRUB-APPROVED.tsv`
yourself — then Part B of the dispatch can run.
```
