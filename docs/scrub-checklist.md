# Public-port scrub checklist

Use this checklist whenever material moves from the private source repository
into this public-ready repository. Treat the source as reference-only: copy
only the minimal configuration or instructions that users need.

## Before copying

- [ ] Read the destination file and decide whether the feature belongs in the
  public package at all.
- [ ] Start from a generic example; never copy a whole private directory just
  because one file is useful.
- [ ] Replace user-specific home paths, host names, device names, project
  names, and account names with documented placeholders.
- [ ] Remove personal wallpaper, screenshot, finance, and private-project
  material rather than trying to anonymize it in place.

## Inspect the proposed content

- [ ] Check text, comments, commands, URLs, and example values for personal
  names or handles, local home paths, and host-specific paths.
- [ ] The public GitHub handle `Calculator5329` is permitted; do not treat it
  as a personal identifier.
- [ ] Remove hardware-address-shaped values and any Bluetooth, network, or
  device identifiers that could identify a machine.
- [ ] Remove credentials and credential-like strings, including API tokens,
  access tokens, and session values. Use environment-variable names or clear
  placeholders in documentation instead.
- [ ] Do not add database files or other generated local-state artifacts.
- [ ] Confirm configs work with user-provided values and do not depend on a
  private project layout or service.

## Before handing off

- [ ] Run `bash tests/verify.sh` from the repository root.
- [ ] Review every reported `file:line` result and remove or redact it; do not
  suppress the verifier for a real secret or personal identifier.
- [ ] Inspect `git diff --check` and the staged-file list to ensure only the
  intended public material is included.
- [ ] Re-read new prose as a first-time user: paths, package names, and setup
  steps should be generic and reproducible.
