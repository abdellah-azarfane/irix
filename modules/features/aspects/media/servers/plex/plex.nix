{...}: {
  flake.nixosModules.plex = { pkgs, lib, ... }: {
    environment.systemPackages =
      (with pkgs; [
        plex
      ])
      ++ lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
        pkgs.plexamp
      ];
  };
}
