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
      darktable
      kdePackages.gwenview
      exiv2
      handbrake
      kdePackages.kdenlive
      mpv
      vlc
      yt-dlp
      imv
      swayimg
      oculante
    ];

    
    home-manager.users.${user} = {
       xdg.configFile = {
         "oculante/config.json".source = ./oculante/config.json;
         "imv/config".source = ./imv/config;
         "swayimg/config".source = ./swayimg/config;
       };
    };
  };
}
