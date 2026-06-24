{ self, ... }: {
  flake.nixosModules.terminals =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.fish
        self.nixosModules.ghostty
        self.nixosModules.shell-common
        self.nixosModules.nushell
        self.nixosModules.starship
        self.nixosModules.multiplexers
      ];
    };
}
