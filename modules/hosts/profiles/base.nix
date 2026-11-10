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
      self.nixosModules.keymap
      self.nixosModules.monitors
      self.nixosModules.unfree
      self.nixosModules.start
      self.nixosModules.autostart
      self.nixosModules.sudo
    ];

    system.stateVersion = "26.11";
  };
}
