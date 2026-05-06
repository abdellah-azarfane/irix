{self, ...}: {
  flake.nixosModules.terminals = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.fish
      self.nixosModules.wezterm
      self.nixosModules.shell-common
      self.nixosModules.nushell
      self.nixosModules.starship     
      self.nixosModules.multiplexers
    ];
  };
}
