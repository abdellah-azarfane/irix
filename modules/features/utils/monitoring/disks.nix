{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        duf # Yet another disk utility
      ];
    };
}
