{ self, inputs, ... }:
{
  flake.nixosModules.hostProfileBase = {
    imports = [
      self.nixosModules.base
      self.nixosModules.core
      self.nixosModules.services
      self.nixosModules.greetd
      self.nixosModules.hardware
      self.nixosModules.nix-ld
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };

    persistance.enable = false;

    preferences.theme = self.lib.theme;

    system.stateVersion = "26.05";
  };
}
