{
  flake.modules.homeManager.utils =
    { pkgs, ...
  }: {
  programs.bottom = {
    enable = true;
  };
 };
}
