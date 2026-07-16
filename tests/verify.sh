#!/usr/bin/env bash
# Public-release verification gate for this repository.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

failures=0

fail() {
  printf '%s\n' "$*" >&2
  failures=1
}

run_install_syntax_check() {
  if [[ -f "$repo_root/install.sh" ]]; then
    printf 'Checking install.sh syntax...\n'
    if ! bash -n "$repo_root/install.sh"; then
      fail 'install.sh: bash syntax check failed'
    fi
  else
    printf 'Skipping install.sh syntax check (install.sh is not present).\n'
  fi
}

run_shellcheck() {
  if ! command -v shellcheck >/dev/null 2>&1; then
    printf 'Skipping shellcheck (not installed).\n'
    return
  fi

  local -a shell_files=()
  mapfile -d '' -t shell_files < <(git -C "$repo_root" ls-files -z -- '*.sh')

  if ((${#shell_files[@]} == 0)); then
    printf 'Skipping shellcheck (no tracked shell files).\n'
    return
  fi

  printf 'Running shellcheck on tracked shell files...\n'
  if ! (
    cd "$repo_root"
    shellcheck "${shell_files[@]}"
  ); then
    fail 'shellcheck failed'
  fi
}

report_matches() {
  local label="$1"
  local pattern="$2"
  local matches

  matches="$(git -C "$repo_root" grep -n -a -E -- "$pattern" || true)"
  if [[ -n "$matches" ]]; then
    fail "Scrub check failed: $label"
    printf '%s\n' "$matches" >&2
  fi
}

run_scrub_scan() {
  printf 'Scanning tracked files for private data...\n'

  # Keep the detector's own source from matching the private values it finds.
  local private_handle='et2''bo'
  local private_user='eth''an'
  local private_home="/home/$private_user"
  local openai_prefix='s''k-'
  local github_prefix='g''hp_'
  local aws_prefix='A''KIA'
  local slack_prefix='x''oxb-'

  report_matches 'private handle' "$private_handle"
  report_matches 'private home path' "$private_home"
  report_matches 'private name' "(^|[^[:alnum:]_])${private_user}([^[:alnum:]_]|$)"
  report_matches 'MAC-address-shaped value' '[[:xdigit:]]{2}[:-]([[:xdigit:]]{2}[:-]){4}[[:xdigit:]]{2}'
  report_matches 'possible API token' "${openai_prefix}[[:alnum:]_-]+|${github_prefix}[[:alnum:]_-]+|${aws_prefix}[[:alnum:]]*|${slack_prefix}[[:alnum:]-]+"

  local file
  while IFS= read -r -d '' file; do
    case "$file" in
      *.db|*.DB|*.sqlite|*.SQLITE)
        fail "Scrub check failed: disallowed database artifact"
        printf '%s:1: tracked database files must not be published\n' "$file" >&2
        ;;
    esac
  done < <(git -C "$repo_root" ls-files -z)
}

run_install_syntax_check
run_shellcheck
run_scrub_scan

if ((failures)); then
  printf 'Verification failed. Remove or redact the listed private data before publishing.\n' >&2
  exit 1
fi

printf 'Verification passed.\n'
