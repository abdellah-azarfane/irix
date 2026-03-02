{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      programs.eza = {
        enable = true;
      };
    };
}
