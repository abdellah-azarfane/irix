{
  flake.nixosModules.noctalia-shell = { config, lib, ... }: {
    irix.apps.noctalia.files."config.toml" = {
      shell = {
        ui_scale = 1.0;                           # content scale for panels and non-bar shell UI
        font_family = "sans-serif";               # Pango family string; Fontconfig handles fallback
        lang = "en";                              # override language detection
        time_format = "{:%H:%M}";                 # default time format for shell UI without its own setting
        date_format = "%A, %x";                   # default date format for shell UI without its own setting
        offline_mode = false;                     # block all outgoing HTTP requests
        telemetry_enabled = false;                # anonymous startup ping
        polkit_agent = false;                     # register Noctalia's native polkit authentication agent
        password_style = "default";               # default | random
        avatar_path = "~/Pictures/avatar.png";
        settings_show_advanced = false;           # show advanced settings by default in Settings
        middle_click_opens_widget_settings = true;# middle-click bar widgets to open their Settings entry
        show_location = true;                     # show weather location text in shell UI
        clipboard_enabled = true;                 # false disables clipboard history, panel, and compositor clipboard hooks
        clipboard_auto_paste = "auto";            # off | auto | ctrl_v | ctrl_shift_v | shift_insert
        clipboard_image_action_command = "";      # image clipboard action; e.g. "gimp {path}" or "satty -f -"

        animation = {
          enabled = true;
          speed = 1.0;                            # 1.0 = normal, 0.5 = 2x slower, 2.0 = 2x faster
        };

        shadow = {
          blur = 12;                              # global surface shadow blur radius; 0 disables all rendered surface shadows
          offset_x = 2;
          offset_y = 2;                           # positive = down
          alpha = 0.55;                           # multiplied by each component's background opacity
        };

        panel = {
          background_blur = true;                 # request compositor blur behind panels via ext-background-effect-v1
          transparency_mode = "solid";            # solid | soft | glass; controls detached panel opacity and card translucency
          attach_launcher = false;                # attach launcher to the bar when a suitable bar is available
          attach_clipboard = false;               # attach clipboard history to the bar when a suitable bar is available
          attach_control_center = true;           # attach Control Center to the bar when a suitable bar is available
          attach_wallpaper = true;                # attach wallpaper picker to the bar when a suitable bar is available
          open_near_click_control_center = false; # open Control Center near the click on the bar
          open_near_click_launcher = false;       # open Launcher near the click on the bar
          open_near_click_clipboard = false;      # open Clipboard near the click on the bar
          open_near_click_wallpaper = false;      # open Wallpaper picker near the click on the bar
        };

        screen_corners = {
          enabled = false;                        # overlay black rounded corners on each screen
          size = 32;                              # corner radius in logical pixels (1-100)
        };

        mpris = {
          blacklist = [ ];                        # optional list of players to hide from media widgets/control-center
        };

        session = {
          actions = [
            {
              action = "lock";
              command = "swaylock -f";
            }
            {
              action = "logout";
              enabled = true;
            }
            {
              action = "command";
              label = "Sleep";
              glyph = "bedtime";
              command = "systemctl suspend";
            }
            {
              action = "shutdown";
              destructive = true;
            }
          ];
        };
      };

      osd = {
        position = "top_right";
      };

      keybinds = {
        validate = [ "return" "kp_enter" ];
        cancel = [ "escape" ];
        left = [ "left" ];
        right = [ "right" ];
        up = [ "up" ];
        down = [ "down" ];
      };

      hooks = {
        started = "systemctl --user start noctalia-ready.target";
        wallpaper_changed = "systemctl --user restart wallpaper-sync.service";
        colors_changed = [
          "systemctl --user reload foot-server.service"
          "logger -t noctalia-hooks 'palette colors changed'"
        ];
        session_locked = [
          "playerctl pause"
          "noctalia:bar-hide"
        ];
        session_unlocked = [
          "noctalia:bar-show"
          "noctalia:dpms-on"
        ];
        logging_out = "logger -t noctalia-hooks 'logout requested'";
        rebooting = "systemctl --user stop backup-sync.service";
        shutting_down = "systemctl --user stop backup-sync.service";
        wifi_enabled = "logger -t noctalia-hooks 'Wi-Fi radio enabled'";
        wifi_disabled = "logger -t noctalia-hooks 'Wi-Fi radio disabled'";
        bluetooth_enabled = "logger -t noctalia-hooks 'Bluetooth powered on'";
        bluetooth_disabled = "logger -t noctalia-hooks 'Bluetooth powered off'";
        battery_low_percent_threshold = 15;
        battery_state_changed = "logger -t noctalia-hooks \"Battery: $NOCTALIA_BATTERY_STATE\"";
        battery_under_threshold = "systemctl --user start battery-low.target";
      };
    };
  };
}
