{
  flake.modules.homeManager.editors =
    { pkgs, ... }:
    {
      programs.emacs = {
        enable = true;
      };
      services.emacs.enable = true;
    };
}
