{ self, ... }:
{
  flake.nixosModules.MainWorkstation = {
    imports = [
      self.nixosModules.hostProfileMainWorkstation
    ];
  };
}