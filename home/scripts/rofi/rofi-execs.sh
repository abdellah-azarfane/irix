#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.dotfiles/user/desktop/rofi/scripts/executables"

if [[ ! -d "$SCRIPT_DIR" ]]; then
    notify-send "Error" "Script directory not found: $SCRIPT_DIR"
    exit 1
fi

MENU_ENTRIES=""

for script in "$SCRIPT_DIR"/*.sh; do
    [[ -f "$script" ]] || continue

    title=$(sed -n '3s/^# Title: //p' "$script")
    description=$(sed -n '4s/^# Description: //p' "$script")

    [[ -z "$title" ]] && title=$(basename "$script" .sh)
    [[ -z "$description" ]] && description="No description provided"

    MENU_ENTRIES+="$title (<i>$description</i>)\n"
done

if [[ -z "$MENU_ENTRIES" ]]; then
    notify-send "No scripts found" "There are no .sh files in $SCRIPT_DIR"
    exit 0
fi

chosen=$(echo -e "$MENU_ENTRIES" | rofi -dmenu -markup-rows \
    -theme "$HOME/.dotfiles/user/desktop/rofi/themes/style-4.rasi" \
    -i -p "Select Script:")

if [[ -z "$chosen" ]]; then
    notify-send "Cancelled" "No script selected"
    exit 0
fi

# Extract only the title part (before the space + “(”)
selected_title=$(echo "$chosen" | sed 's/ (.*//')

# Now search for a script whose title matches, and additionally verify it's executable
matched_script=""
for script in "$SCRIPT_DIR"/*.sh; do
    [[ -f "$script" ]] || continue
    title=$(sed -n '3s/^# Title: //p' "$script")
    [[ -z "$title" ]] && title=$(basename "$script" .sh)

    if [[ "$selected_title" == "$title" ]]; then
        matched_script="$script"
        break
    fi
done

if [[ -z "$matched_script" ]]; then
    notify-send "Error" "No matching script for \"$selected_title\""
    exit 1
fi

# Optionally verify it is executable; if not, try to set +x or warn
if [[ ! -x "$matched_script" ]]; then
    notify-send "Warning" "Script \"$matched_script\" is not executable — trying to set permission"
    chmod +x "$matched_script" 2>/dev/null || {
        notify-send "Error" "Failed to mark script as executable"
        exit 1
    }
fi

# Finally execute
nohup bash "$matched_script" &>/dev/null &
notify-send "Executing" "$selected_title"
