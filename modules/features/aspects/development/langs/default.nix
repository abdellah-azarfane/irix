{ self, ... }: {
  flake.nixosModules.langs = { ... }: {
    imports = [
      self.nixosModules.lang-shell
      self.nixosModules.lang-python
      self.nixosModules.lang-lua
      self.nixosModules.lang-devops
      self.nixosModules.lang-utilities
      self.nixosModules.lang-cpp
      self.nixosModules.lang-rust
      self.nixosModules.lang-go
      self.nixosModules.lang-javascript
      self.nixosModules.lang-web
      self.nixosModules.lang-markdown
    ];
  };
}
