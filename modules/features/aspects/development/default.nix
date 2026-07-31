{ self, ... }: {
  flake.nixosModules.development = { ... }: {
    imports = [
      self.nixosModules.editors
      self.nixosModules.android
      self.nixosModules.databases
      ## languages
      self.nixosModules.lang-web
      self.nixosModules.lang-systems
      self.nixosModules.lang-scripting
      ###
      self.nixosModules.misc
      #      self.nixosModules.hermes
      self.nixosModules.vcs
      self.nixosModules.virt
      self.nixosModules.sops
    ];
  };
}
