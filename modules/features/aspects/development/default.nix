{ self, ... }: {
  flake.nixosModules.development = { ... }: {
    imports = [
      self.nixosModules.editors
      self.nixosModules.android
      self.nixosModules.async
      self.nixosModules.cloud
      self.nixosModules.databases
      self.nixosModules.infra
      ## languages
      self.nixosModules.lang-web
      self.nixosModules.lang-systems
      self.nixosModules.lang-scripting
      ###
      self.nixosModules.misc
      self.nixosModules.ml
      self.nixosModules.opsec
      self.nixosModules.vcs
    ];
  };
}