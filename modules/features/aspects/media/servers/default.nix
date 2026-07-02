{self, ...}: {
  flake.nixosModules.servers = {pkgs, ...}:  {
    imports = [
      self.nixosModules.jellyfin
    ];
  };
}
