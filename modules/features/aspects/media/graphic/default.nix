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

    hjem.users.${user}.files = {
      # Assumes you put the config files in the exact same folder as graphic.nix
      ".config/oculante/config.json" = {
        clobber = true;
        source = ./oculante/config.json;
      };
      ".config/imv/config" = {
        clobber = true;
        source = ./imv/config;
      };
      ".config/swayimg/config" = {
        clobber = true;
        source = ./swayimg/config;
      };
    };
  };
}
