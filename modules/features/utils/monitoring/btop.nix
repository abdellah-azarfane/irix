{
  flake.modules.homeManager.utils =
    { pkgs, ... }: {
  programs.btop = {
    enable = true;
  };
 };
}
