{ self, ... }:
{
  flake.nixosModules.hostProfileLaptop = {
    imports = [
      self.nixosModules.hostProfileBase
      self.nixosModules.desktop
    ];
  };
}
