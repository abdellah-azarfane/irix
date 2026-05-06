{
  inputs,
  self,
  lib,
  ...
}: {
  flake.nixosModules.fish = { pkgs, config, ... }: let
    user = config.preferences.user.name;
    myAliases = self.lib.mkShellAliases { inherit pkgs lib; };
  in {
    home-manager.users.${user} = {
      programs.fish = {
        enable = true;
        shellAliases = myAliases;
        interactiveShellInit = ''
          set -gx HISTFILE "$HOME/.local/share/fish/fish_history"
          set -gx MCFLY_HISTFILE "$HOME/.local/share/mcfly/history.db"
        '' + (self.lib.mkFishShellInit { inherit pkgs lib; });
      };
    };
  };

  perSystem = {
    pkgs,
    self',
    ...
  }: let
    fishConf = pkgs.writeText "fishy-fishy" (self.lib.mkFishShellInit { inherit pkgs lib; });
  in {
    packages.fish = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fish;
      extraPackages = [
        pkgs.zoxide
      ];
      flags = {
        "-C" = "source ${fishConf}";
      };
    };
  };
}
