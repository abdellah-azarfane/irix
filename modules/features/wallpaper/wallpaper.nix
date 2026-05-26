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

      home-manager.users.${user} = {
        home.file."wallpapers" = {
          source = inputs.wallpapers.packages.${system}.default;
          recursive = true;
        };
      };
    };
}
