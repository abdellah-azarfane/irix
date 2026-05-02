{ self, ... }: {
  flake.nixosModules.editors = { pkgs, ... }: {
    imports = [
      self.nixosModules.zededitor
      self.nixosModules.emacs
    ];
  };
}
