{ self, ... }: {
  flake.nixosModules.media = { pkgs, ... }: {
    imports = [
      self.nixosModules.audio
      self.nixosModules.design
      self.nixosModules.graphic
      self.nixosModules.servers
      self.nixosModules.social
      self.nixosModules.torrenting
    ];
  };
}
