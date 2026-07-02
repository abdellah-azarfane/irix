{
  flake.nixosModules.graphic = {
    pkgs,
    config,
    ...
  }:
  let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = with pkgs; [
      exiv2 # Excellent, lightweight CLI tool for reading/writing image metadata
      handbrake
      mpv
      yt-dlp
      imv
    ];


    home-manager.users.${user} = {
       xdg.configFile = {
         "imv/config".source = ./imv/config;
       };
    };
  };
}
