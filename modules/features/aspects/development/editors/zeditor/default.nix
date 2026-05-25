{self, ...} : {
  flake.nixosModules.zeditor = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    imports = [
      self.nixosModules.zedsettings
      self.nixosModules.zedkeymaps
      self.nixosModules.zedappearance
      self.nixosModules.zedextensions
      self.nixosModules.zedlsp
      self.nixosModules.zedlangs
      self.nixosModules.zedterminal
    ];
    home-manager.users.${user} = {
      programs.zed-editor = {
        enable = true;
        package = inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
