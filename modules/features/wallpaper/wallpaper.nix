{
  flake.nixosModules.wallpaper =
    {
      pkgs,
      inputs,
      config,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = [
        pkgs.awww
      ];

    };
}
