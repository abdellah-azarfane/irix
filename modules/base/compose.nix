{ self, ... }:
{
  flake.nixosModules.base = {
    imports = [
      self.nixosModules.user
      self.nixosModules.hjem
      self.nixosModules.tomlgener
    ];
  };
}
