{
      flake.nixosModules.noctalia-widgets-bar = { config, lib, ... }: {

        irix.apps.noctalia.files."widgets.toml" = {
          widget = {
            # --- Core UI Elements ---
            launcher = { glyph = "menu-2"; };
            clipboard = { glyph = "clipboard-list"; };
            session = { glyph = "lock"; };
            wallpaper = { glyph = "photo"; };

            gap = {
              type = "spacer";
              length = 24;
            };

            spacer = {
              type = "spacer";
              capsule = false;
            };

            # --- Clocks ---
            clock = {
              format = "{:%H:%M}\n{:%d/%m}";
              vertical_format = "{:%H\n%M}";
            };

            "clock-12h" = {
              type = "clock";
              format = "{:%-I:%M %p}";
            };

            "clock-seconds" = {
              type = "clock";
              format = "{:%H:%M:%S}";
              vertical_format = "{:%H\n%M\n%S}";
            };

            # --- Workspaces & Taskbar ---
            workspaces = {
              display = "id";             # none | id | name
              focused_color = "primary";
              occupied_color = "secondary";
              empty_color = "surface_variant";
            };

            taskbar = {
              group_by_workspace = true;
              show_all_outputs = true;
              only_active_workspace = true;
              show_workspace_label = false;
              hide_empty_workspaces = true;
            };

            active_window = {
              min_length = 80;
              max_length = 260;
              icon_size = 14;
              title_scroll = "on_hover";
            };

            control-center = {
             # custom_image = "/path/to/image.png";
            };

            # --- Status & Hardware ---
            network = { capsule_group = "status"; };

            bluetooth = {
              capsule_group = "status";
              show_label = true;
            };

            weather = {
              max_length = 180;
              show_condition = false;
            };

            notifications = { hide_when_no_unread = true; };
            brightness = { show_label = false; };

            keyboard_layout = { display = "short"; }; # short | full

            lock_keys = {
              display = "short";
              show_caps_lock = true;
              show_num_lock = true;
              show_scroll_lock = false;
              hide_when_off = false;
            };

            # --- Audio & Media ---
            volume = {
              capsule_fill = "secondary";
              capsule_radius = 0.0;       # square this widget's capsule
              capsule_border = "";        # no border on this widget
              device = "output";          # output | input
              show_label = false;
            };

            input-volume = {
              type = "volume";
              device = "input";
            };

            output-volume = {
              type = "volume";
              device = "output";
            };

            audio-vis = {
              type = "audio_visualizer";
              width = 64;
              bands = 20;
              show_when_idle = true;
              low_color = "primary";
              high_color = "secondary";
            };

            media = {
              min_length = 80;
              max_length = 220;
              art_size = 24;
              title_scroll = "on_hover";
            };

            # --- System Monitors ---
            cpu = {
              type = "sysmon";
              stat = "cpu_usage";
            };

            cpu-graph = {
              type = "sysmon";
              stat = "cpu_usage";
              display = "graph";
              show_label = false;
            };

            temp = {
              type = "sysmon";
              stat = "cpu_temp";
            };

            ram = {
              type = "sysmon";
              stat = "ram_used";
            };

            disk = {
              type = "sysmon";
              stat = "disk_pct";
              path = "/";
            };

            # --- Batteries ---
            battery = {
              type = "battery";
              device = "auto";
            };

            internal_battery = {
              type = "battery";
              device = "BAT0";
            };

            second_battery = {
              type = "battery";
              device = "/org/freedesktop/UPower/devices/battery_BAT1";
            };

            gamepad_battery = {
              type = "battery";
              device = "/org/freedesktop/UPower/devices/gaming_input_hid_001";
            };

            # --- Scripted Widgets ---
            my_widget = {
              type = "scripted";
              script = "~/.config/noctalia/scripts/my_widget.lua";
              hot_reload = true;
              # any extra keys are readable from Lua via barWidget.getConfig()
              my_setting = "value";
            };

            screen_recorder = {
              type = "scripted";
              script = "scripts/screen_recorder.lua";
              directory = "";
              filename_pattern = "recording_%Y%m%d_%H%M%S";
              video_source = "portal";
              video_codec = "h264";
              audio_codec = "opus";
              audio_source = "default_output";
              quality = "very_high";
              frame_rate = 60;
              color_range = "limited";
              resolution = "original";
              show_cursor = true;
              copy_to_clipboard = false;
              restore_portal = false;
              replay_enabled = false;
              replay_duration = 30;
              replay_storage = "ram";
              hide_inactive = false;
            };
          };
        };
      };
    }
