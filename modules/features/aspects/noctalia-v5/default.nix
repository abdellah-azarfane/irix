{ self, ... }: {
  flake.nixosModules.noctalia = { ... }: {
    imports = [
      self.nixosModules.noctalia-core
      self.nixosModules.noctalia-shell
      self.nixosModules.noctalia-bar
      self.nixosModules.noctalia-dock
      self.nixosModules.noctalia-desktop-widgets
      self.nixosModules.noctalia-services
      self.nixosModules.noctalia-theme
      self.nixosModules.noctalia-widgets-bar
    ];
      irix.apps.noctalia.enable = true;
  };
}
