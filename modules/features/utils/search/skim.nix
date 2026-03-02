{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      programs.skim = {
        enable = true;
      };
    };
}
