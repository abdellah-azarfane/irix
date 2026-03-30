{...}: {
  flake.nixosModules.torrenting = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        qbittorrent
      ];
  };
}
