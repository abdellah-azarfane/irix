{
  flake.modules.homeManager.terminals =
    { pkgs, ... }:
    {
      programs.zellij = {
        enable = true;
      };
    };
}
