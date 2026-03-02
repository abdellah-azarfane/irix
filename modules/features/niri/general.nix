{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {
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
        # Overview
        # ============================================================================
        overview = {
          zoom = 0.6;
          workspace-shadow.enable = false;
        };
        # ============================================================================
        # Screenshot
        # ============================================================================
        screenshot-path = "~/pictures/screenshots/screenshot_%Y-%m-%d_%H-%M-%S.png";
        # ============================================================================
        # Layout
        # ============================================================================
        layout = {
          shadow = {
            softness = 10;
            spread = 5;
            offset = {
              x = 0;
              y = 5;
            };
            draw-behind-window = false;
            color = "#090D1270";
            inactive-color = "#00000054";
          };

          background-color = "transparent";
          gaps = 12;
          struts = {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
          };
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
            enable = false;
            width = 1;
            active = {
              color = "rgb(255 200 127)";
            };
            inactive = {
              color = "rgb(80 80 80)";
            };
          };

          border = {
            enable = false;
            width = 1;
            active = {
              gradient = {
                from = "#090E13";
                to = "#C14043";
                angle = 45;
                relative-to = "workspace-view";
              };
            };
            inactive = {
              color = "#090D12";
            };
          };

          tab-indicator = {
            place-within-column = true;
            gap = 5;
            width = 4;
            length = {
              total-proportion = 1.0;
            };
            position = "left";
            gaps-between-tabs = 2;
            corner-radius = 0;
            active = {
              gradient = {
                from = "#c4b28a";
                to = "#c4746e";
                angle = 45;
              };
            };
            inactive = {
              gradient = {
                from = "#0d0c0c";
                to = "#808080";
                angle = 45;
                relative-to = "workspace-view";
              };
            };
            urgent = {
              gradient = {
                from = "#E46876";
                to = "#c4746e";
                angle = 45;
              };
            };
          };
        };
      };
    };
}
