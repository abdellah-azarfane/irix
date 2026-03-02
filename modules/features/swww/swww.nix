{
  flake.modules.homeManager.swww =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Ensure the package is actually installed in the user profile
      home.packages = [ pkgs.swww ];
      systemd.user.services.swww = {
        Unit = {
          Description = "Efficient animated wallpaper daemon for Wayland";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ]; # Ensure the compositor is fully up
        };
        Service = {
          Type = "simple";
          # Use swww-daemon
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          Restart = "on-failure";
          RestartSec = 1;
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
