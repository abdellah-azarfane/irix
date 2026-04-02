{ self, ... }: {
  flake.nixosModules.editors = { ... }: {
    imports = [
      self.nixosModules.zededitor
      self.nixosModules.emacs
      self.nixosModules.qtcreator
    ];
  };
}
