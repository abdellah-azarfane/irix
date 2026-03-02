{
  flake.modules.homeManager.utils =
    { pkgs, config, ... }:
    let
      aliases = import ../common/aliases.nix;
    in
    {
      programs.fish = {
        shellAliases = aliases;
      };
    };
}
