# Plan — screenshot/asset pipeline

Deliverable for roadmap "Later" item **"Screenshot/asset pipeline once
Ethan approves captures."** (`docs/roadmap.md`). Ethan's decision:
**APPROVED** (2026-07-19).

This lane owns only this plan folder (`docs/plans/<this-task-id>/`).
It produces the plan; it does not touch source or the roadmap. The
harvesting session ticks the roadmap item from these deliverables.

## Contents

| File | What it is |
| --- | --- |
| [`design.md`](design.md) | The design: the one invariant (sanitized demo profile, scrubbed + human-approved), why not blur/mockups, the five pipeline stages, and the verify.sh gate. |
| [`scene-manifest.md`](scene-manifest.md) | What to capture — v1 four-scene gating set + later scenes, capture recipes, doc placement, per-scene rules. |
| [`DISPATCH.md`](DISPATCH.md) | Exact follow-up task spec(s) for the source changes: Part A (scripts + fail-closed gate, agent-doable now) and Part B (embed approved images, blocks on owner). |
| [`owner-action-packet.md`](owner-action-packet.md) | The capture steps only Ethan can run (needs a real display; must be a throwaway demo profile, never the real desktop). |

## One-paragraph summary

Ethan approved desktop captures, but the repo's standing rule bans
photographing the *real* desktop for good reason: a raster image can't be
`git grep`-ed, so a stray hostname or private project name in one corner
would ship to a public repo permanently. The pipeline resolves this by
moving the guarantee to capture time — shoot a sanitized throwaway demo
profile that never held personal data — then backs it with a metadata
scrub, a human-signed approval ledger keyed by sha256, and a fail-closed
`tests/verify.sh` image gate. Mermaid diagrams stay; screenshots augment
them. Build the tooling + gate via `DISPATCH.md` Part A (no human needed),
capture via the owner-action packet, then embed via Part B.

## Recommended next steps

1. Dispatch **Part A** of `DISPATCH.md` (scripts + verify gate) — no
   human dependency.
2. When Part A lands, run the **owner-action packet** to produce the four
   approved v1 PNGs + ledger rows.
3. Dispatch **Part B** to embed them.
4. Amend the `CLAUDE.md` / roadmap "diagrams only" rule to "sanitized
   demo-profile captures only" — owner-gated, surface as a review card.
```
