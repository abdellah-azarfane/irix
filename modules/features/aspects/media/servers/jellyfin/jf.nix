{...}: {
  flake.nixosModules.jellyfin = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      jellyfin
      ];
  };
}
