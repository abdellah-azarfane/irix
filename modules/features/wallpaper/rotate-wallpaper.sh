#!/usr/bin/env bash

set -euo pipefail

wallpaper_dir="${1:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)}"
wallpaper_dir="$(readlink -f "$wallpaper_dir" || printf '%s' "$wallpaper_dir")"
current_wallpaper="${2:-$HOME/.cache/irix/current-wallpaper}"
daemon_started=0

start_daemon() {
  if [[ "$daemon_started" -eq 0 ]]; then
    if ! awww query >/dev/null 2>&1; then
      awww-daemon >/dev/null 2>&1 &
      sleep 0.2
    fi
    daemon_started=1
  fi
}

apply_random_wallpaper() {
  local -a wallpapers=()
  local -a candidates=()
  local wallpaper
  local current_target=""

  mkdir -p "$(dirname -- "$current_wallpaper")"

  mapfile -t wallpapers < <(find "$wallpaper_dir" -type f \
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
    awww img "$wallpaper"
  fi
}

start_daemon

while true; do
  apply_random_wallpaper
  sleep 120
done