{ self, ... }: {
  flake.nixosConfigurations.main = self.lib.mkNixos {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.MainWorkstation
    ];
  };
}