{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        package = pkgs.yazi;
      };
    };
}
