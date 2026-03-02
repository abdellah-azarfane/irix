{
  flake.modules.homeManager.utils =
    { pkgs, config, ... }:
    {
      programs.man.generateCaches = false;
      programs.fish = {
        enable = true;
      };
    };
}
