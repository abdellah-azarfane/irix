{
  flake.modules.homeManager.editors =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        texmaker
      ];
    };
}
