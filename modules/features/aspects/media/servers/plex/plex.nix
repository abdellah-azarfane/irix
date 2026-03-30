{...}: {
  flake.nixosModules.plex = {pkgs, config, ...}: {
      environment.systemPackages = with pkgs; [
        plex
        plexamp
      ];
    };
}
