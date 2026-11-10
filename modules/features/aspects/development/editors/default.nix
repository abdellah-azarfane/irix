{ self, ... }: {
  flake.nixosModules.editors = { pkgs, ... }: {
    imports = [
      self.nixosModules.zeditor
      self.nixosModules.emacs
      self.nixosModules.nvim
    ];
  };
}
