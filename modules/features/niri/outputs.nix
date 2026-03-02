{
  flake.modules.homeManager.niri =
    { config, lib, ... }:
    {
      programs.niri.settings = {
        outputs = {
          # Main laptop display
          "eDP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 144.0;
            };
            scale = 1.0;
            position = {
              x = 0;
              y = 0;
            };
          };

          # External HDMI display (same config for both hosts)
          "HDMI-A-1" = {
            mode = {
              width = 3840;
              height = 2160;
              refresh = 60.0;
            };
            scale = 1.5;
            position = {
              x = 1920; # positioned to the right of the main display
              y = 0;
            };
          };
        };
      };
    };
}
