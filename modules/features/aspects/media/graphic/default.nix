{
  flake.nixosModules.graphic = {
    pkgs,
    config,
    inputs,
    ...
  }:
  let
    user = config.preferences.user.name;
    oculantePrevious = inputs.nixpkgs-25_11.legacyPackages.${pkgs.stdenv.hostPlatform.system}.oculante;
  in {
    environment.systemPackages = with pkgs; [
      darktable
      djv
      exiv2
      handbrake
      kdePackages.kdenlive
      mpv
      vlc
      yt-dlp
      imv
      swayimg
      oculantePrevious
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
