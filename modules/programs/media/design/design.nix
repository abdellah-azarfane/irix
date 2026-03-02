{
  flake.modules.homeManager.design =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        figma-linux # Unofficial Figma client for Linux
        inkscape # Vector graphics editor
        gimp3-with-plugins # GNU manipulation program
        blender # 3D creation software
      ];
    };
}
