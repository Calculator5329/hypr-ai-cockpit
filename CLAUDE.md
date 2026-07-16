# CLAUDE.md — hypr-ai-cockpit

Public derivative of the private `infra/ai-cockpit-setup` chezmoi repo.
This repo WILL BE MADE PUBLIC — treat every commit as world-readable.

## Mission

Shareable Hyprland AI-cockpit: plain dotfiles mirroring `~/.config` +
`install.sh`, with walkthrough docs (devices, keybinds, AI desktop apps,
GatesAI, projects hub). No chezmoi requirement for users.

## Hard rules

- **Nothing personal, ever**: no finance data/keys, no Ethan-specific
  paths, hostnames, device names/MACs, tokens, wallpapers with personal
  info, or private project names. Finance module ships disabled with a
  placeholder config. When porting from `ai-cockpit-setup`, scrub —
  don't copy blind.
- Source repo `infra/ai-cockpit-setup` is READ-ONLY reference for lanes
  working here (its fence is docs-only).
- No screenshots of the real desktop — diagrams only (owner decision
  2026-07-16, see ai-cockpit-setup docs/intent.md).
- Repo visibility stays PRIVATE until Ethan flips it himself.
- No binaries of Claude Desktop/Codex Desktop/Cursor/GatesAI committed —
  install scripts + instructions only.

## Verify

```sh
bash tests/verify.sh   # shellcheck install.sh + scripts, scrub-scan for
                       # personal tokens, config lint where cheap
```

Until tests/verify.sh exists, minimum bar: `bash -n install.sh` and a
grep sweep for personal identifiers (see docs/scrub-checklist.md).
