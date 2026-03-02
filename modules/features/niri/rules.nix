{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        layer-rules = [
          {
            matches = [ { namespace = "^wallpaper$"; } ];
            place-within-backdrop = true;
          }
          {
            matches = [ { namespace = "^launcher"; } ];
            shadow = {
              enable = true;
              softness = 40;
              spread = 5;
              offset = {
                x = 0;
                y = 5;
              };
              draw-behind-window = true;
              color = "#00000050";
            };
          }
        ];

        # ============================================================================
        # Window Rules
        # ============================================================================
        window-rules = [
          # Calculator apps
          {
            matches = [ { app-id = "qalculate-gtk"; } ];
            open-maximized = true;
          }
          {
            matches = [ { app-id = "calcure"; } ];
            open-maximized = true;
          }

          # Television launcher
          {
            matches = [ { app-id = "television-launcher"; } ];
            default-column-width = {
              proportion = 0.8;
            };
            open-floating = true;
            default-window-height = {
              fixed = 700;
            };
            focus-ring = {
              enable = true;
              width = 1;
              active = {
                gradient = {
                  from = "#E46876";
                  to = "#c4746e";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
              inactive = {
                gradient = {
                  from = "#505050";
                  to = "#808080";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
            };
            shadow = {
              enable = true;
              softness = 40;
              spread = 5;
              offset = {
                x = 0;
                y = 5;
              };
              draw-behind-window = true;
              color = "#00000050";
            };
          }
          {
            matches = [ { title = "Television Picker"; } ];
            default-column-width = {
              proportion = 0.8;
            };
            open-floating = true;
            default-window-height = {
              fixed = 700;
            };
            focus-ring = {
              enable = true;
              width = 1;
              active = {
                gradient = {
                  from = "#E46876";
                  to = "#c4746e";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
              inactive = {
                gradient = {
                  from = "#505050";
                  to = "#808080";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
            };
            shadow = {
              enable = true;
              softness = 40;
              spread = 5;
              offset = {
                x = 0;
                y = 5;
              };
              draw-behind-window = true;
              color = "#00000050";
            };
          }

          # Global transparency
          {
            matches = [ { is-active = true; } ];
            opacity = 0.98;
          }
          {
            matches = [ { is-active = false; } ];
            opacity = 0.98;
          }

          # Wezterm CSD handling
          {
            matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
          }

          # Firefox Picture-in-Picture
          {
            matches = [
              {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
        ];
      };
    };
}
