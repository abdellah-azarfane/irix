{
  flake.modules.homeManager.editors =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;
      };
    };
}
