{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {

        # ============================================================================
        # Keybindings
        # ============================================================================
        binds = {
          # System & Core Controls
          "Mod+Escape".action.spawn = "hyprlock";

          # Focus Navigation
          "Mod+Left".action.focus-column-left = [ ];
          "Mod+Right".action.focus-column-right = [ ];
          "Mod+Up".action.focus-window-up = [ ];
          "Mod+Down".action.focus-window-down = [ ];
          "Mod+H".action.focus-column-left = [ ];
          "Mod+L".action.focus-column-right = [ ];
          "Mod+K".action.focus-window-up = [ ];
          "Mod+J".action.focus-window-down = [ ];
          "Mod+Tab".action.focus-workspace-previous = [ ];
          "Alt+Tab".action.focus-window-previous = [ ];

          # Window & Column Manipulation
          "Mod+C".action.close-window = [ ];
          "Mod+V".action.toggle-window-floating = [ ];
          "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
          "Mod+Comma".action.consume-or-expel-window-left = [ ];
          "Mod+Period".action.consume-or-expel-window-right = [ ];

          # Move Column
          "Mod+Ctrl+Left".action.move-column-left = [ ];
          "Mod+Ctrl+Right".action.move-column-right = [ ];
          "Mod+Ctrl+Down".action.move-column-to-workspace-down = [ ];
          "Mod+Ctrl+Up".action.move-column-to-workspace-up = [ ];
          "Mod+Ctrl+H".action.move-column-left = [ ];
          "Mod+Ctrl+L".action.move-column-right = [ ];
          "Mod+Ctrl+J".action.move-column-to-workspace-down = [ ];
          "Mod+Ctrl+K".action.move-column-to-workspace-up = [ ];

          # Move Window
          "Mod+Ctrl+S".action.move-window-up-or-to-workspace-up = [ ];
          "Mod+Ctrl+A".action.move-window-down-or-to-workspace-down = [ ];

          # Maximize & Resize
          "Mod+F".action.maximize-column = [ ];
          "Mod+Shift+F".action.fullscreen-window = [ ];
          "Mod+Z".action.toggle-column-tabbed-display = [ ];
          "Mod+Shift+C".action.center-column = [ ];
          "Mod+R".action.switch-preset-column-width = [ ];
          "Mod+Shift+R".action.switch-preset-window-height = [ ];
          "Mod+Ctrl+R".action.reset-window-height = [ ];
          "Mod+Minus".action.set-column-width = "-10%";
          "Mod+Equal".action.set-column-width = "+10%";
          "Mod+Shift+Minus".action.set-window-height = "-10%";
          "Mod+Shift+Equal".action.set-window-height = "+10%";

          # Workspace Navigation (Dynamic)
          "Mod+Alt+Up".action.move-workspace-up = [ ];
          "Mod+Alt+Down".action.move-workspace-down = [ ];
          "Mod+Shift+Up".action.focus-workspace-up = [ ];
          "Mod+Shift+Down".action.focus-workspace-down = [ ];

          # Workspace Navigation (Numeric)
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+0".action.focus-workspace = 10;

          # Move to Workspace (Numeric)
          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;
          "Mod+Shift+0".action.move-column-to-workspace = 10;

          # Application Launchers (Primary)
          "Mod+A".action.spawn = "fuzzel";
          "Mod+W".action.spawn = "wezterm";
          "Mod+B".action.spawn = [
            "firefox"
            "-p"
            "Personal"
          ];
          "Mod+D".action.spawn = [
            "wezterm"
            "-e"
            "yazi"
          ];
          "Mod+E".action.spawn = [
            "wezterm"
            "-e"
            "nvim"
          ];

          # Application Launchers (Secondary - Shift)
          "Mod+Shift+W".action.spawn = "ghostty";
          "Mod+Shift+B".action.spawn = "brave";
          "Mod+Shift+D".action.spawn = "thunar";
          #  "Mod+Shift+E".action.spawn = [ "emacsclient" "-c" ]; til i learn it

          # Application Launchers (Tertiary - Ctrl)
          "Mod+Ctrl+E".action.spawn = "zeditor";

          # Screenshots
          "Mod+S".action.screenshot-screen = [ ];
          "Print".action.screenshot-screen = [ ];
          "Mod+Shift+S".action.screenshot = [ ];
          "Shift+Print".action.screenshot = [ ];
          "Mod+Alt+S".action.screenshot-window = [ ];
          "Ctrl+Print".action.screenshot-window = [ ];

          # Mouse & Trackpad Scroll Bindings
          "Mod+WheelScrollDown" = {
            action.focus-workspace-down = [ ];
            cooldown-ms = 50;
          };
          "Mod+WheelScrollUp" = {
            action.focus-workspace-up = [ ];
            cooldown-ms = 50;
          };
          "Mod+WheelScrollRight" = {
            action.focus-column-right = [ ];
            cooldown-ms = 100;
          };
          "Mod+WheelScrollLeft" = {
            action.focus-column-left = [ ];
            cooldown-ms = 100;
          };
          "Mod+TouchpadScrollUp".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.02+"
          ];
          "Mod+TouchpadScrollDown".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.02-"
          ];

          # Multimedia & Hardware Controls
          "XF86AudioRaiseVolume" = {
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%+"
            ];
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%-"
            ];
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
            allow-when-locked = true;
          };
          "XF86MonBrightnessUp" = {
            action.spawn = [
              "brightnessctl"
              "set"
              "+5%"
            ];
            allow-when-locked = true;
          };
          "XF86MonBrightnessDown" = {
            action.spawn = [
              "brightnessctl"
              "set"
              "5%-"
            ];
            allow-when-locked = true;
          };
          "XF86AudioPlay" = {
            action.spawn = [
              "playerctl"
              "play-pause"
            ];
            allow-when-locked = true;
          };
          "XF86AudioNext" = {
            action.spawn = [
              "playerctl"
              "next"
            ];
            allow-when-locked = true;
          };
          "XF86AudioPrev" = {
            action.spawn = [
              "playerctl"
              "previous"
            ];
            allow-when-locked = true;
          };

          # Overview
          "Mod+X" = {
            action.toggle-overview = [ ];
            repeat = false;
          };
        };
      };
    };
}
