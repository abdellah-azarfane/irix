{ inputs, ... }: {
  flake.nixosModules.homeManager = {
    imports = [
      # Official Home Manager NixOS module
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
