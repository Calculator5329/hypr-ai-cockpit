#!/usr/bin/env bash
# Install the cockpit configuration and its small, curated Arch package set.

set -euo pipefail

dry_run=false
copy_mode=false
repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
config_root="$repo_root/config"
config_home="$HOME/.config"
backup_root=""

log() {
  printf '==> %s\n' "$*"
}

warn() {
  printf 'Warning: %s\n' "$*" >&2
}

print_command() {
  local argument
  printf '+ '
  for argument in "$@"; do
    printf '%q ' "$argument"
  done
  printf '\n'
}

run() {
  print_command "$@"
  if [[ "$dry_run" == false ]]; then
    "$@"
  fi
}

usage() {
  cat <<'EOF'
Usage: ./install.sh [--dry-run] [--copy]

Install every directory under config/ into ~/.config and install the curated
Arch package manifests. Existing ~/.config targets are moved to one timestamped
~/.config-backup-<timestamp>/ directory before being replaced.

Options:
  --dry-run  Print actions without changing files or installing packages.
  --copy     Copy configuration directories instead of symlinking them.
  --help     Show this help text.
EOF
}

ensure_backup_root() {
  local timestamp suffix=0

  if [[ -n "$backup_root" ]]; then
    return
  fi

  timestamp="$(date +%Y%m%d-%H%M%S)"
  backup_root="$HOME/.config-backup-$timestamp"
  while [[ -e "$backup_root" ]]; do
    suffix=$((suffix + 1))
    backup_root="$HOME/.config-backup-$timestamp-$suffix"
  done
  run mkdir -p -- "$backup_root"
}

same_symlink_target() {
  local target="$1"
  local source="$2"

  [[ -L "$target" ]] && [[ "$(readlink -f -- "$target")" == "$source" ]]
}

same_copy_content() {
  local target="$1"
  local source="$2"

  [[ -d "$target" && ! -L "$target" ]] && diff -qr -- "$source" "$target" >/dev/null
}

backup_target() {
  local target="$1"
  local name="$2"

  ensure_backup_root
  log "Backing up $target to $backup_root/$name"
  run mv -- "$target" "$backup_root/$name"
}

install_config_directory() {
  local source="$1"
  local name target
  name="${source##*/}"
  target="$config_home/$name"

  if [[ "$copy_mode" == true ]]; then
    if same_copy_content "$target" "$source"; then
      log "Configuration is already current: $target"
      return
    fi
  elif same_symlink_target "$target" "$source"; then
    log "Configuration is already linked: $target"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_target "$target" "$name"
  fi

  if [[ "$copy_mode" == true ]]; then
    log "Copying $source to $target"
    run cp -a -- "$source" "$target"
  else
    log "Linking $target to $source"
    run ln -s -- "$source" "$target"
  fi
}

install_configurations() {
  local source

  if [[ ! -d "$config_root" ]]; then
    warn "No config directory found at $config_root; skipping configuration install."
    return
  fi

  run mkdir -p -- "$config_home"

  while IFS= read -r -d '' source; do
    install_config_directory "$source"
  done < <(find "$config_root" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)
}

read_package_list() {
  local list="$1"
  sed -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' "$list"
}

install_official_packages() {
  local list="$repo_root/packages/arch-official.txt"
  local -a packages=()

  if [[ ! -r "$list" ]]; then
    warn "Official package list is missing: $list"
    return
  fi

  mapfile -t packages < <(read_package_list "$list")
  if ((${#packages[@]} == 0)); then
    warn "Official package list is empty: $list"
    return
  fi

  if ! command -v pacman >/dev/null 2>&1; then
    warn "pacman is unavailable; skipping official packages."
    return
  fi
  if ! command -v sudo >/dev/null 2>&1; then
    warn "sudo is unavailable; skipping official packages."
    return
  fi

  log "Installing curated official Arch packages"
  run sudo pacman -S --needed -- "${packages[@]}"
}

install_aur_packages() {
  local list="$repo_root/packages/arch-aur.txt"
  local helper=""
  local -a packages=()

  if [[ ! -r "$list" ]]; then
    warn "AUR package list is missing: $list"
    return
  fi

  mapfile -t packages < <(read_package_list "$list")
  if ((${#packages[@]} == 0)); then
    warn "AUR package list is empty: $list"
    return
  fi

  if command -v paru >/dev/null 2>&1; then
    helper="paru"
  elif command -v yay >/dev/null 2>&1; then
    helper="yay"
  else
    warn "No supported AUR helper found (tried paru and yay); skipping AUR packages."
    return
  fi

  log "Installing curated AUR packages with $helper"
  run "$helper" -S --needed -- "${packages[@]}"
}

while (($# > 0)); do
  case "$1" in
    --dry-run)
      dry_run=true
      ;;
    --copy)
      copy_mode=true
      ;;
    --help | -h)
      usage
      exit 0
      ;;
    *)
      warn "Unknown option: $1"
      usage >&2
      exit 2
      ;;
  esac
  shift
done

install_configurations
install_official_packages
install_aur_packages
