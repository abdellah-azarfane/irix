#!/usr/bin/env bash

set -uo pipefail

wallpaper_dir="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)}"
wallpaper_dir="$(readlink -f "$wallpaper_dir" || printf '%s' "$wallpaper_dir")"
current_wallpaper="${2:-$HOME/.cache/irix/current-wallpaper}"
rotation_interval="${3:-${WALLPAPER_ROTATE_SECONDS:-120}}"
daemon_started=0

log() {
  printf '[rotate-wallpaper] %s\n' "$*" >&2
}

start_daemon() {
  if ! command -v awww >/dev/null 2>&1; then
    log "awww command not found in PATH"
    return 1
  fi

  if ! command -v awww-daemon >/dev/null 2>&1; then
    log "awww-daemon command not found in PATH"
    return 1
  fi

  if [[ "$daemon_started" -eq 0 ]]; then
    if ! awww query >/dev/null 2>&1; then
      awww-daemon >/dev/null 2>&1 &
      for _ in {1..20}; do
        if awww query >/dev/null 2>&1; then
          daemon_started=1
          break
        fi
        sleep 0.2
      done
    else
      daemon_started=1
    fi

    if [[ "$daemon_started" -eq 0 ]]; then
      log "awww-daemon did not become ready"
      return 1
    fi
  fi
}

apply_random_wallpaper() {
  local -a wallpapers=()
  local -a candidates=()
  local wallpaper
  local current_target=""

  mkdir -p "$(dirname -- "$current_wallpaper")"

  mapfile -t wallpapers < <(find -L "$wallpaper_dir" -type f \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
    | sort)

  if [[ "${#wallpapers[@]}" -eq 0 ]]; then
    return
  fi

  if [[ -L "$current_wallpaper" ]]; then
    current_target="$(readlink -f "$current_wallpaper" || true)"
  fi

  if [[ -n "$current_target" && "${#wallpapers[@]}" -gt 1 ]]; then
    for wallpaper in "${wallpapers[@]}"; do
      [[ "$wallpaper" == "$current_target" ]] && continue
      candidates+=("$wallpaper")
    done
  else
    candidates=("${wallpapers[@]}")
  fi

  if [[ "${#candidates[@]}" -eq 0 ]]; then
    return
  fi

  wallpaper="${candidates[RANDOM % ${#candidates[@]}]}"

  if [[ -n "$wallpaper" ]]; then
    ln -sfn "$wallpaper" "$current_wallpaper"
    if ! awww img "$wallpaper"; then
      log "failed to apply wallpaper: $wallpaper"
      return 1
    fi
  fi
}

while true; do
  if start_daemon; then
    apply_random_wallpaper || true
  fi

  sleep "$rotation_interval"
done
