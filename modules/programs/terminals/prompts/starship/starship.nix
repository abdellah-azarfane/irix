{
  flake.modules.homeManager.terminals =
    { pkgs, ... }:
    {

      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
}
