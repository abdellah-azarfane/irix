{
  flake.nixosModules.noctalia-core = { config, pkgs, lib, inputs, ... }: {

    irix.apps.noctalia = {
      enable = true;
      homeConfigDir = ".config/noctalia";

      files."config.toml" = {
      };
    };
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
