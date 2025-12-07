#!/usr/bin/env bash

# Toggle Waybar: if running → stop; if stopped → start
'reload_waybar() {
    niri msg action do-screen-transition --delay-ms 200

    if systemctl --user is-active --quiet rh-waybar.service; then
        # Service is running → stop it
        systemctl --user stop rh-waybar.service
    else
        # Service is not running → start it
        systemctl --user start rh-waybar.service
    fi
}'
