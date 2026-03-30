{self, ...}: {
  flake.nixosModules.terminals = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.wezterm
      self.nixosModules.shell-common
      self.nixosModules.nushell
      self.nixosModules.zsh
      self.nixosModules.starship     
      self.nixosModules.multiplexers
    ];
  };
}
