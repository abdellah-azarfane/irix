{ inputs, self, ... }:
{
  flake.wrappersModules.niri =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      # Custom options for this module
      options.terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };

      config = {
        v2-settings = true;
        settings = {

          # ============================================================================
          # General Settings
          # ============================================================================
          hotkey-overlay.skip-at-startup = _: { };
          prefer-no-csd = _: { };

          cursor = {
            xcursor-size = 24;
            hide-after-inactive-ms = 2000;
          };

          environment = {
            DISPLAY = ":0";
            QT_QPA_PLATFORMTHEME = "qt6ct";
            XCURSOR_THEME = "Bibata-Modern-Classic";
          };

          # ============================================================================
          # Input
          # ============================================================================
          input = {
            workspace-auto-back-and-forth = _: { };
            keyboard = {
              xkb = {
                layout = "us,fr,ara";
                options = "grp:alt_shift_toggle";
              };
              repeat-delay = 300;
              repeat-rate = 90;
              numlock = _: { };
            };
            touchpad = {
              dwt = _: { };
              dwtp = _: { };
              tap = _: { };
              drag = true;
              middle-emulation = _: { };
              accel-speed = -0.3;
              scroll-factor = 1.0;
            };
            mouse = {
              accel-speed = 0.1;
              accel-profile = "adaptive";
              scroll-factor = 0.9;
              middle-emulation = _: { };
            };
            focus-follows-mouse = _: { };
          };

          # ============================================================================
          # Gestures
          # ============================================================================
          gestures = {
            dnd-edge-view-scroll = {
              trigger-width = 30;
              delay-ms = 100;
              max-speed = 1500;
            };
            dnd-edge-workspace-switch = {
              trigger-height = 50;
              delay-ms = 100;
              max-speed = 1500;
            };
          };

          # ============================================================================
          # Rules
          # ============================================================================
          layer-rules = [
              {
                matches = [ { namespace = "^wallpaper$"; } ];
                place-within-backdrop = true;
              }
              {
               matches = [ { namespace = "^quickshell$"; } ];
               place-within-backdrop = true;
              }
              {
               matches = [ { namespace = "dms:blurwallpaper"; } ];
               place-within-backdrop = true;
              }
          ];

          window-rules = [
            {
              geometry-corner-radius = 20.0;
              clip-to-geometry = true;
            }

            {
              matches = [ { app-id = "dev.zed.Zed"; } ];
              opacity = 0.85;
            }
            {
              matches = [ { is-active = false; } ];
              opacity = 0.7;
            }
          ];

          # ============================================================================
          # Layout
          # ============================================================================
          layout = {
            gaps = 5;
            shadow = {
              softness = 10;
              spread = 5;
              offset = _: {
                props = {
                  x = 0;
                  y = 5;
                };
              };
            };
            struts = {
              left = 0;
              right = 0;
              top = 0;
              bottom = 0;
            };
            background-color = "transparent";
            center-focused-column = "never";

            preset-column-widths = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
              { proportion = 1.0; }
            ];

            default-column-width = {
              proportion = 0.5;
            };

            preset-window-heights = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
              { proportion = 1.0; }
              { fixed = 720; }
            ];

            focus-ring = {
              width = 2;
              active-color = "#c4b28a";
              inactive-color = "#665c54";
            };

            border = {
              width = 1;
              "active-gradient" = _: {
                props = {
                  from = "#090E13";
                  to = "#1a1a1a";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
              inactive-color = "#090D12";
            };

            tab-indicator = {
              place-within-column = _: { };
              gap = 5;
              width = 4;
              length = _: {
                props = {
                  total-proportion = 1.0;
                };
              };
              position = "left";
              gaps-between-tabs = 2;
              corner-radius = 0;
              "active-gradient" = _: {
                props = {
                  from = "#c4b28a";
                  to = "#c4746e";
                  angle = 45;
                };
              };
              "inactive-gradient" = _: {
                props = {
                  from = "#0d0c0c";
                  to = "#808080";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
              "urgent-gradient" = _: {
                props = {
                  from = "#E46876";
                  to = "#c4746e";
                  angle = 45;
                };
              };
            };
          };

          overview = {
            zoom = 0.6;
          };

          # ============================================================================
          # Startup
          # ============================================================================
          xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;
       /*   spawn-at-startup = [
            [
              "dbus-update-activation-environment"
              "--systemd"
              "WAYLAND_DISPLAY"
              "XDG_CURRENT_DESKTOP"
            ]
            [ "dms" "run" ]
          ];
          */
          # ============================================================================
          # Keybindings
          # ============================================================================
          binds = {
            "Mod+Return".spawn = config.terminal;

            # Focus Navigation
            "Mod+Left".focus-column-left = _: { };
            "Mod+Right".focus-column-right = _: { };
            "Mod+Up".focus-window-up = _: { };
            "Mod+Down".focus-window-down = _: { };
            "Mod+H".focus-column-left = _: { };
            "Mod+L".focus-column-right = _: { };
            "Mod+K".focus-window-up = _: { };
            "Mod+J".focus-window-down = _: { };
            "Mod+Tab".focus-workspace-previous = _: { };
            "Alt+Tab".focus-window-previous = _: { };

            # Move Column
            "Mod+Ctrl+Left".move-column-left = _: { };
            "Mod+Ctrl+Right".move-column-right = _: { };
            "Mod+Ctrl+Down".move-column-to-workspace-down = _: { };
            "Mod+Ctrl+Up".move-column-to-workspace-up = _: { };
            "Mod+Ctrl+H".move-column-left = _: { };
            "Mod+Ctrl+L".move-column-right = _: { };
            "Mod+Ctrl+J".move-column-to-workspace-down = _: { };
            "Mod+Ctrl+K".move-column-to-workspace-up = _: { };

            # Move Window
            "Mod+Ctrl+S".move-window-up-or-to-workspace-up = _: { };
            "Mod+Ctrl+A".move-window-down-or-to-workspace-down = _: { };

            # Maximize & Resize
            "Mod+F".maximize-column = _: { };
            "Mod+Shift+F".fullscreen-window = _: { };
            "Mod+Z".toggle-column-tabbed-display = _: { };
            "Mod+C".close-window = _: { };
            "Mod+Shift+C".center-column = _: { };
            "Mod+R".switch-preset-column-width = _: { };
            "Mod+Shift+R".switch-preset-window-height = _: { };
            "Mod+Ctrl+R".reset-window-height = _: { };

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";

            # Monitor Navigation
            "Mod+Alt+Left".focus-monitor-left = _: { };
            "Mod+Alt+Right".focus-monitor-right = _: { };

            # Workspace Navigation
            "Mod+Alt+Up".move-workspace-up = _: { };
            "Mod+Alt+Down".move-workspace-down = _: { };
            "Mod+Shift+Up".focus-workspace-up = _: { };
            "Mod+Shift+Down".focus-workspace-down = _: { };

            # Workspace Focus & Movement
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+0".focus-workspace = 10;

            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Shift+5".move-column-to-workspace = 5;
            "Mod+Shift+6".move-column-to-workspace = 6;
            "Mod+Shift+7".move-column-to-workspace = 7;
            "Mod+Shift+8".move-column-to-workspace = 8;
            "Mod+Shift+9".move-column-to-workspace = 9;
            "Mod+Shift+0".move-column-to-workspace = 10;

            # Overview
            "Mod+X".toggle-overview = _: { };

            # Noctalia Shell Commands
                        "Mod+S".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "spotlight"
                          "toggle"
                        ];
                        "Mod+comma".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "settings"
                          "toggle"
                        ];
                        "Mod+space".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "spotlight"
                          "toggle"
                        ];
                        "Mod+Escape".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "lock"
                          "lock"
                        ];
                        "Mod+P".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "dashboard"
                          "toggle"
                        ];
                        "Mod+Alt+E".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "emoji"
                          "toggle"
                        ];
                        "Mod+N".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "nightlight"
                          "enable"
                        ];
                        "Mod+Alt+N".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "nightlight"
                          "disable"
                        ];
                        "Mod+Shift+N".spawn = [
                          "dms"
                          "ipc"
                          "call"
                          "caffeine"
                          "toggle"
                        ];

            # Mouse Scroll Bindings
            "Mod+WheelScrollDown" = _: {
              props = {
                cooldown-ms = 50;
              };
              content = {
                focus-workspace-down = _: { };
              };
            };

            "Mod+WheelScrollUp" = _: {
              props = {
                cooldown-ms = 50;
              };
              content = {
                focus-workspace-up = _: { };
              };
            };

            "Mod+WheelScrollRight" = _: {
              props = {
                cooldown-ms = 100;
              };
              content = {
                focus-column-right = _: { };
              };
            };

            "Mod+WheelScrollLeft" = _: {
              props = {
                cooldown-ms = 100;
              };
              content = {
                focus-column-left = _: { };
              };
            };
            "Mod+TouchpadScrollUp".spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.02+"
            ];
            "Mod+TouchpadScrollDown".spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.02-"
            ];

            # Multimedia & Hardware
            "XF86AudioRaiseVolume" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "5%+"
                ];
              };
            };
            "XF86AudioLowerVolume" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "5%-"
                ];
              };
            };
            "XF86AudioMute" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SINK@"
                  "toggle"
                ];
              };
            };
            "XF86AudioMicMute" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SOURCE@"
                  "toggle"
                ];
              };
            };
            "XF86MonBrightnessUp" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "brightnessctl"
                  "set"
                  "+5%"
                ];
              };
            };
            "XF86MonBrightnessDown" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "brightnessctl"
                  "set"
                  "5%-"
                ];
              };
            };
            "XF86AudioPlay" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "playerctl"
                  "play-pause"
                ];
              };
            };
            "XF86AudioNext" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "playerctl"
                  "next"
                ];
              };
            };
            "XF86AudioPrev" = _: {
              props = {
                allow-when-locked = true;
              };
              content = {
                spawn = [
                  "playerctl"
                  "previous"
                ];
              };
            };

            # Screenshots
            "Mod+Alt+S".spawn-sh = "${lib.getExe pkgs.grim} -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy";
            "Mod+Shift+E".spawn-sh = "${pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe pkgs.swappy} -f -";
            "Mod+Shift+S".spawn-sh = ''
              ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - | ${pkgs.wl-clipboard}/bin/wl-copy
            '';

            # App Launcher
            "Mod+d".spawn = [
              (self.mkWhichKeyExe pkgs [
                {
                  key = "b";
                  desc = "Bluetooth";
                  cmd = "dms ipc call bluetooth togglePanel";
                }
                {
                  key = "w";
                  desc = "Wifi";
                  cmd = "dms ipc call wifi togglePanel";
                }
                {
                  key = "f";
                  desc = "File Manager";
                  cmd = "thunar";
                }
                {
                  key = "y";
                  desc = "Tui fileManager";
                  cmd = "yazi";
                }
                {
                  key = "t";
                  desc = "Telegram";
                  cmd = "Telegram";
                }
                {
                  key = "d";
                  desc = "Discord";
                  cmd = "vesktop";
                }
                {
                  key = "m";
                  desc = "Youtube Music";
                  cmd = "pear-desktop";
                }
                {
                  key = "p";
                  desc = "Helium Browser";
                  cmd = "helium";
                }
                {
                  key = "s";
                  desc = "Pavucontrol";
                  cmd = "${lib.getExe pkgs.pavucontrol}";
                }
              ])
            ];
          };
        };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrappersModules.niri ];
      };
    };
}
