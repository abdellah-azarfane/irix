{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-kbptr
      ];
    };
}
