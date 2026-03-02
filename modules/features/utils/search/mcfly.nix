{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      programs.mcfly = {
        enable = true;
        fzf.enable = true;
      };
    };
}
