{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        # ============================================================================
        # Startup Programs
        # ============================================================================
        spawn-at-startup = [
          { command = [ "xwayland-satellite" ]; }
          { command = [ "noctalia-shell" ]; }
        ];
      };
    };
}
