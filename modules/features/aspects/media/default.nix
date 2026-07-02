{ self, ... }: {
  flake.nixosModules.media = { pkgs, ... }: {
    imports = [
      self.nixosModules.audio
      self.nixosModules.graphic
      self.nixosModules.obs
      self.nixosModules.servers
      self.nixosModules.social
    ];
  };
}
