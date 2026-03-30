 {
  flake.nixosModules.design = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        figma-linux
        inkscape
        gimp3-with-plugins
        blender
      ];
    };
}
