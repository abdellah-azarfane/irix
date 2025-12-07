#!/usr/bin/env bash
# Bluetooth Manager via Rofi
# Clean and safe version

set -euo pipefail

ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

bluetooth_menu() {
    while true; do
        bt_power_status=$(bluetoothctl show | awk '/Powered/ {print $2}')
        options=()

        if [[ "$bt_power_status" == "yes" ]]; then
            options+=("⊹ Turn Off Bluetooth <i>(Disable Radio)</i>")
            options+=("⊹ Scan for Devices <i>(Discover New)</i>")
            options+=("⊹ Make Discoverable <i>(Pairable Mode)</i>")

            # Get paired devices
            mapfile -t paired_devices < <(bluetoothctl paired-devices | awk '{print $2 " " substr($0, index($0,$3))}')

            for entry in "${paired_devices[@]}"; do
                mac="${entry%% *}"
                name="${entry#* }"
                [[ -z "$mac" ]] && continue

                if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                    options+=("⊹ Disconnect $name <i>(Connected)</i>")
                else
                    options+=("⊹ Connect $name <i>(Paired)</i>")
                fi
                options+=("⊹ Unpair $name <i>(Remove)</i>")
            done

            # Get available (non-paired) devices
            mapfile -t available_devices < <(bluetoothctl devices | awk '{print $2 " " substr($0, index($0,$3))}')

            for entry in "${available_devices[@]}"; do
                mac="${entry%% *}"
                name="${entry#* }"
                # Skip if already paired
                if ! bluetoothctl paired-devices | grep -q "$mac"; then
                    options+=("⊹ Pair $name <i>(Available)</i>")
                fi
            done
        else
            options+=("⊹ Turn On Bluetooth <i>(Enable Radio)</i>")
        fi

        [[ ${#options[@]} -eq 0 ]] && options=("⊹ No Options Available <i>(Check Service)</i>")

        selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -markup-rows -p "λ " -theme "$ROFI_THEME")
        [[ -z "${selected:-}" ]] && exit 0

        case "$selected" in
        *"Turn On Bluetooth"*)
            bluetoothctl power on
            notify-send "Bluetooth" "Enabled"
            ;;
        *"Turn Off Bluetooth"*)
            bluetoothctl power off
            notify-send "Bluetooth" "Disabled"
            ;;
        *"Scan for Devices"*)
            notify-send "Bluetooth" "Scanning for devices (5s)..."
            timeout 5s bluetoothctl scan on || true
            bluetoothctl scan off || true
            notify-send "Bluetooth" "Scan completed"
            ;;
        *"Make Discoverable"*)
            bluetoothctl discoverable on
            notify-send "Bluetooth" "Now discoverable for 5 minutes"
            (sleep 300 && bluetoothctl discoverable off) &
            ;;
        *"Connect "*)
            name=$(echo "$selected" | sed 's/⊹ Connect \(.*\) <i>.*/\1/')
            mac=$(bluetoothctl paired-devices | grep "$name" | awk '{print $2}')
            bluetoothctl connect "$mac" && notify-send "Bluetooth" "Connected to $name"
            ;;
        *"Disconnect "*)
            name=$(echo "$selected" | sed 's/⊹ Disconnect \(.*\) <i>.*/\1/')
            mac=$(bluetoothctl paired-devices | grep "$name" | awk '{print $2}')
            bluetoothctl disconnect "$mac" && notify-send "Bluetooth" "Disconnected from $name"
            ;;
        *"Pair "*)
            name=$(echo "$selected" | sed 's/⊹ Pair \(.*\) <i>.*/\1/')
            mac=$(bluetoothctl devices | grep "$name" | awk '{print $2}')
            bluetoothctl pair "$mac" && notify-send "Bluetooth" "Paired with $name"
            ;;
        *"Unpair "*)
            name=$(echo "$selected" | sed 's/⊹ Unpair \(.*\) <i>.*/\1/')
            mac=$(bluetoothctl paired-devices | grep "$name" | awk '{print $2}')
            bluetoothctl remove "$mac" && notify-send "Bluetooth" "Removed $name"
            ;;
        *"No Options"*)
            notify-send "Bluetooth" "No actions available"
            ;;
        esac
    done
}

bluetooth_menu
