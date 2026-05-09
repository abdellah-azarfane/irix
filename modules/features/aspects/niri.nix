{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.niri = { config, lib, pkgs, inputs, ... }:

let
  user = config.preferences.user.name;
  selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  noctaliaExe = lib.getExe selfpkgs.noctalia-shell;
  autostartEntries = map
    (item:
      if builtins.isString item
      then { command = [ "sh" "-c" item ]; }
      else { command = [ (lib.getExe item) ]; }
    )
    config.preferences.autostart;
in
{ 
  home-manager.users.${user} = {
  imports = [ inputs."niri-flake".homeModules.niri ];

   programs.niri = {
    enable = true;

    settings = {
    # ============================================================================
    # General Settings
    # ============================================================================
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;

    cursor = {
      size = 24;
      hide-after-inactive-ms = 2000;
    };
    
    # ============================================================================
    # Environment
    # ============================================================================
    # Required for xwayland-satellite X11 app compatibility
    environment = {
      DISPLAY = ":0";
    };
  
     # ============================================================================
     # Outputs
     # ============================================================================
      outputs = lib.mapAttrs (_: monitor: {
        mode = {
          width = monitor.width;
          height = monitor.height;
          refresh = monitor.refreshRate;
        };
        scale = monitor.scale;
        position = {
          x = monitor.x;
          y = monitor.y;
        };
      }) (lib.filterAttrs (_: monitor: monitor.enabled) config.preferences.monitors);
   
    # ============================================================================
    # Input
    # ============================================================================
      input = {
        keyboard = {
          xkb = {
            layout = "us,fr,ara";
            options = "grp:alt_shift_toggle,caps:escape";
          };
        repeat-delay = 300;
        repeat-rate = 90;
        numlock = true;        
        };

      touchpad = {
        dwt = true;
        dwtp = true;
        tap = true;
        natural-scroll = false;
        accel-speed = -0.3;
        middle-emulation = true;
        scroll-factor = 1.0;
        drag = true;
      };

      mouse = {
        accel-speed = 0.1;
        accel-profile = "adaptive";
        scroll-factor = 0.9;
        middle-emulation = true;
      };        
      focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
      workspace-auto-back-and-forth = true;
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
      hot-corners.enable = false;
    };
       
    # ============================================================================
    # Layer Rules
    # ============================================================================
    layer-rules = [
      {
        matches = [ { namespace = "^wallpaper$"; } ];
        place-within-backdrop = true;
      }
      {
        # Changed the regex to target anything starting with "noctalia"
        matches = [ { namespace = "^noctalia"; } ]; 
        shadow = {
          enable = true;
          softness = 40;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          draw-behind-window = true;
          # Our Gruvbox bg0 (#282828) with 50 (hex) alpha transparency 
          color = "#28282850"; 
        };
      }
    ];
    # ============================================================================
    # Window Rules
    # ============================================================================
    window-rules = [
      {
        matches = [ { is-active = true; } ];
        opacity = 0.6;
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.8;
      }
    ];
    
        # ============================================================================
        # Animations
        # ============================================================================
        animations = {
          slowdown = 0.8;

          window-open.kind.easing = {
            duration-ms = 150;
            curve = "ease-out-expo";
          };

          window-close.kind.easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };

          horizontal-view-movement.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          window-movement.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          window-resize.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          config-notification-open-close.kind.spring = {
            damping-ratio = 0.6;
            stiffness = 1000;
            epsilon = 0.001;
          };

          screenshot-ui-open.kind.easing = {
            duration-ms = 200;
            curve = "ease-out-quad";
          };

          overview-open-close.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };

    # ============================================================================
    # Layout
    # ============================================================================
      layout = {
        gaps = 5;
        shadow = {
         softness = 10;
         spread = 5;
         offset = {
           x = 0;
           y = 5;
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
        default-column-width = { proportion = 0.5; };
        preset-window-heights = [
         { proportion = 0.33333; }
         { proportion = 0.5; }
         { proportion = 0.66667; }
         { proportion = 1.0; }
         { fixed      = 720; }
          ];
        focus-ring = {
          width = 2;
          active.color = config.preferences.theme.base09;
          inactive = {
          color = "#665c54";
        };
        };  
        border = {
          enable = true;
          width = 1;
          active = {
           gradient = {
             from = "#cc241d";
             to = "#d79921";
             angle = 45;
             relative-to = "workspace-view";
           };
         };
         inactive = {
           color = "#3c3836";
          };
        };
        tab-indicator = {
        place-within-column = true;
        gap = 5;
        width = 4;
        length = { total-proportion = 1.0; };
        position = "left";
        gaps-between-tabs = 2;     
        corner-radius = 4; 

        active = {
          gradient = {
            # Gruvbox Bright Yellow to Bright Orange
            from = "#fabd2f";
            to = "#fe8019";
            angle = 45;
          };
        };
        
        inactive = {
          gradient = {
            # Gruvbox bg1 (Dark Brown/Gray) to Standard Gray
            from = "#3c3836";
            to = "#928374";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        
        urgent = {
          gradient = {
            # Gruvbox Bright Red to Bright Yellow
            from = "#fb4934";
            to = "#fabd2f";
            angle = 45;
          };
        };
      };
    };

        # ============================================================================
        # Keybindings
        # ============================================================================
        binds = with lib; {
        "Mod+Return".action.spawn = "kitty"; 


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
        "Mod+C".action.close-window = [ ];
        "Mod+Shift+C".action.center-column = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";
        
        # Monitor Navigation
        "Mod+Alt+Left".action.focus-monitor-left = [ ];
        "Mod+Alt+Right".action.focus-monitor-right = [ ];

        # Workspace Navigation (Dynamic)
        "Mod+Alt+Up".action.move-workspace-up = [ ];
        "Mod+Alt+Down".action.move-workspace-down = [ ];
        "Mod+Shift+Up".action.focus-workspace-up = [ ];
        "Mod+Shift+Down".action.focus-workspace-down = [ ];

        # Workspace Focus
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

        # Move to Workspaces
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
        

        # Overview
        "Mod+X".action.toggle-overview = [ ];

        # --- CLI Commands & Scripts (Noctalia-shell mainly) ---        
        "Mod+S".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call launcher toggle" ];
        "Mod+comma".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call launcher settings" ];
        "Mod+space".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call launcher command"];
        "Mod+Escape".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call lockScreen lock" ];
        "Mod+P".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call sessionMenu toggle" ];
        "Mod+Alt+E".action.spawn = [ "sh" "-c" "${noctaliaExe} ipc call launcher emoji" ];


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

        "Mod+TouchpadScrollUp".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+" ];
        "Mod+TouchpadScrollDown".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-" ];

        # Multimedia & Hardware Controls
        "XF86AudioRaiseVolume" = {
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action.spawn = [ "brightnessctl" "set" "+5%" ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [ "brightnessctl" "set" "5%-" ];
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn = [ "playerctl" "play-pause" ];
          allow-when-locked = true;
         };
        "XF86AudioNext" = {
          action.spawn = [ "playerctl" "next" ];
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = [ "playerctl" "previous" ];
          allow-when-locked = true;
        };
       # ============================================================================
       # Screenshot
       # ============================================================================
        "Mod+Alt+S".action.spawn = [ "sh" "-c" "${lib.getExe pkgs.grim} -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy" ];
        "Mod+Shift+E".action.spawn = [ "sh" "-c" "${pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe pkgs.swappy} -f -" ];
        
        "Mod+Shift+S".action.spawn = [ (lib.getExe (pkgs.writeShellApplication {
          name = "screenshot";
          text = ''
            ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -w 0)" - \
            | ${pkgs.wl-clipboard}/bin/wl-copy
          '';
        })) ];

        
          "Mod+d".action.spawn = [ (self.mkWhichKeyExe pkgs [
            {
              key = "b";
              desc = "Bluetooth";
              cmd = "${noctaliaExe} ipc call bluetooth togglePanel";
            }
            {
              key = "w";
              desc = "Wifi";
              cmd = "${noctaliaExe} ipc call wifi togglePanel";
            }
            {
              key = "f";
              desc = "File Manager";
              cmd = "dolphin";
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
          ]) ];
      };
     
     
    # ============================================================================
    # Overview
    # ============================================================================
    overview = {
      zoom = 0.6;
      workspace-shadow.enable = false;
    };
     
    # ============================================================================
    # Startup Programs
    # ============================================================================
      spawn-at-startup = [
        { command = [ "${lib.getExe pkgs.xwayland-satellite}" ]; }
        { command = [ "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" ]; }
      ] ++ autostartEntries;
    };
  };

  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = noctaliaExe;
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "niri.service" ];
   };
  };
 };
}
