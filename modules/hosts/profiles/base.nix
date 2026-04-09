{ self, ... }:
{
  flake.nixosModules.hostProfileBase = {
    imports = [
      self.nixosModules.base
      self.nixosModules.homeManager
      self.nixosModules.core
      self.nixosModules.services
      self.nixosModules.greetd
      self.nixosModules.hardware
      self.nixosModules.nix-ld
    ];

    persistance.enable = false;

    system.stateVersion = "26.05";
  };
}
