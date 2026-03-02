{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        # ============================================================================
        # Environment
        # ============================================================================
        # Required for xwayland-satellite X11 app compatibility
        environment = {
          DISPLAY = ":0";
        };

        # ============================================================================
        # Input
        # ============================================================================
        input = {
          keyboard = {
            xkb = {
              layout = "us,fr,ara";
              options = "grp:win_space_toggle";
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
      };
    };
}
